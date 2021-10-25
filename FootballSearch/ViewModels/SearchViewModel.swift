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
    
    @ObservedObject private var playersViewModel = FootballListViewModel<Player>()
    @ObservedObject private var teamsViewModel = FootballListViewModel<Team>()
    @ObservedObject var searchedTextListener = SearchedTextListener()

    @Published var players: [Player] = []
    @Published var teams: [Team] = []
    @Published var isBusy = false
    
    private var cancellables: Set<AnyCancellable> = []
    
    var shouldShowEmptyView: Bool {
        !searchedTextListener.debouncedText.isEmpty && isSearchResultEmpty && !isBusy
    }
    
    var isSearchResultEmpty: Bool {
        isPlayersEmpty && isTeamsEmpty
    }
    
    var isPlayersEmpty: Bool {
        playersViewModel.isDataEmpty
    }
    
    var isTeamsEmpty: Bool {
        teamsViewModel.isDataEmpty
    }
    
    func searchPlayers(searchText: String, shouldReset: Bool = true) {
        playersViewModel.search(searchText: searchText, shouldReset: shouldReset)
    }
    
    func searchTeams(searchText: String, shouldReset: Bool = true) {
        teamsViewModel.search(searchText: searchText, shouldReset: shouldReset)
    }
    
    func morePlayers() {
        searchPlayers(searchText: searchedTextListener.debouncedText, shouldReset: false)
    }
    
    func moreTeams() {
        searchTeams(searchText: searchedTextListener.debouncedText, shouldReset: false)
    }
    
    init() {
        searchedTextListener.$debouncedText.sink { [weak self] text in
            self?.searchPlayers(searchText: text)
            self?.searchTeams(searchText: text)
        }
        .store(in: &cancellables)
        playersViewModel.$data.sink { [weak self] data in
            self?.players = data
        }
        .store(in: &cancellables)
        teamsViewModel.$data.sink { [weak self] data in
            self?.teams = data
        }
        .store(in: &cancellables)
        playersViewModel.$isBusy.sink { [weak self] isBusy in
            self?.isBusy = isBusy
        }
        .store(in: &cancellables)
    }
    
}
