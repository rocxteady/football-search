//
//  SearchViewModel.swift
//  FootballSearch
//
//  Created by Ulaş Sancak on 23.10.2021.
//

import Foundation
import Combine
import SwiftUI
import API

class FootballListViewModel<T: APIIdentifiable>: ObservableObject {
    
    @Published var data: [T] = []
    @Published var isBusy = false
    private var offset = -10
    private var searchCancellable: AnyCancellable? {
        willSet {
            searchCancellable?.cancel()
        }
    }
    
    var isDataEmpty: Bool {
        data.isEmpty
    }
    
    func search(searchText: String, shouldReset: Bool = true) {
        if shouldReset {
            offset = -10
        }
        guard !searchText.isEmpty else {
            data = []
            return
        }
        isBusy = true
        let searchAPI = try! SearchAPI<T>(requestModel: SearchRequestModel(searchString: searchText, offset: offset + 10))
        searchCancellable = searchAPI.publish_start().sink { [weak self] completion in
            switch completion {
            case .failure(let error):
                print(error.localizedDescription)
            case .finished:
                self?.offset += 10
            }
            self?.isBusy = false
        } receiveValue: { [weak self] (response) in
            let data = response.result.data
            data.forEach { object in
                if let player = object as? Player {
                    player.favorited = FavoritesViewModel.shared.isFavorited(player: player)
                } else if let team = object as? Team {
                    team.favorited = FavoritesViewModel.shared.isFavorited(team: team)
                }
            }
            if shouldReset {
                self?.data = response.result.data
                try! PersistenceController.shared.container.viewContext.save()
            } else {
                self?.data.append(contentsOf: response.result.data)
            }
        }
    }
    
}
