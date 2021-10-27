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
    
    private let favoritesViewModel = FavoritesViewModel.shared
    
    private var offset = -10
    private var searchCancellable: AnyCancellable? {
        willSet {
            searchCancellable?.cancel()
        }
    }
    
    var isDataEmpty: Bool {
        data.isEmpty
    }
    
    var handleError: (_ error: String) -> Void = { _ in }
    
    init() {
        if T.self == Player.self {
            favoritesViewModel.removedPlayer = { [weak self] playerID in
                guard let player = self?.data.first(where: { $0.id == playerID }) as? Player else {
                    return
                }
                player.favorited = false
            }
        } else if T.self == Team.self {
            favoritesViewModel.removedTeam = { [weak self] teamID in
                guard let team = self?.data.first(where: { $0.id == teamID }) as? Team else {
                    return
                }
                team.favorited = false
            }
        }
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
                self?.handleError(error.localizedDescription)
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
                self?.data = data
            } else {
                self?.data.append(contentsOf: response.result.data)
            }
        }
    }
    
}
