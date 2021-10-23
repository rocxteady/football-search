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
            self.data = FootballData(players: [Player(id: "0", name: "Ulas", age: "33", club: "Sancak"),
                                              Player(id: "0", name: "Ulas", age: "33", club: "Sancak")], teams: [Team(id: "0", name: "Trabzonspor", city: "Trabzon", stadium: "Şenol Güneş")])
        }
    }
    
}
