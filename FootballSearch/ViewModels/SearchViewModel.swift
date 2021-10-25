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
    private var searchCancellable: AnyCancellable? {
        willSet {
            searchCancellable?.cancel()
        }
    }
    
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
    
    func search(searchText: String) {
        guard !searchText.isEmpty else {
            data.players = []
            data.teams = []
            return
        }
        let playersSearchAPI = try! SearchAPI<PlayersResult>(requestModel: SearchRequestModel(searchString: searchText, searchType: .players, offset: 0))
        let teamsSearchAPI = try! SearchAPI<TeamsResult>(requestModel: SearchRequestModel(searchString: searchText, searchType: .teams, offset: 0))
        searchCancellable = playersSearchAPI.publish_start().zip(teamsSearchAPI.publish_start()).sink { completion in
            switch completion {
            case .failure(let error):
                print(error.localizedDescription)
            case .finished:
                print("Fisined")
            }
        } receiveValue: { [weak self] (playersResponse, teamsResponse) in
            self?.data.players = playersResponse.result.players
            self?.data.teams = teamsResponse.result.teams
        }
    }
    
    init() {
        searchedTextListener.$debouncedText.sink { [weak self] text in
            self?.search(searchText: text)
        }
        .store(in: &cancellables)
    }
    
}
