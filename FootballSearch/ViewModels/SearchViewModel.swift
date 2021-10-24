//
//  SearchViewModel.swift
//  FootballSearch
//
//  Created by Ulaş Sancak on 23.10.2021.
//

import Foundation
import Combine
import SwiftUI

class SearchViewMdoel: ObservableObject {
    
    @Published var data: FootballData = FootballData(players: [], teams: [])
    @ObservedObject var searchedTextListener = SearchedTextListener()
    private var cancellables: Set<AnyCancellable> = []
    
    var shouldShowEmptyView: Bool {
        !searchedTextListener.debouncedText.isEmpty && isSearchResultEmpty
    }
    
    var isSearchResultEmpty: Bool {
        data.isEmpty
    }
    
    var isPlayersEmpty: Bool {
        data.players.isEmpty
    }
    
    var isTeamsEmpty: Bool {
        data.teams.isEmpty
    }
    
    init() {
        searchedTextListener.$debouncedText.sink { text in
            print("Text")
        }
        .store(in: &cancellables)
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            self.data = FootballData(players: [Player(playerID: "0", playerFirstName: "Ulaş", playerSecondName: "Sancak", playerAge: "33", playerClub: "Sancak"),
                                              Player(playerID: "0", playerFirstName: "Ulaş", playerSecondName: "Sancak", playerAge: "33", playerClub: "Sancak")], teams: [Team(id: "0", name: "Trabzonspor", city: "Trabzon", stadium: "Şenol Güneş")])
        }
        let api = try! PlayerSearchAPI(requestModel: SearchRequestModel(searchString: "milan", searchType: "players", offset: 0))
        api.publish_start().sink { completion in
            switch completion {
            case .failure(let error):
                print(error.localizedDescription)
            case .finished:
                print("finished")
            }
        } receiveValue: { response in
            print(response)
        }.store(in: &cancellables)

    }
    
}
