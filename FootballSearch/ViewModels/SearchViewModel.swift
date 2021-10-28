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
    @Published var showingAlert = false
    @Published var isPlayersCompleted = false
    @Published var isTeamsCompeleted = false

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
    
    init() {
        searchedTextListener.$debouncedText.sink { [weak self] text in
            self?.searchPlayers(searchText: text)
            self?.searchTeams(searchText: text)
        }
        .store(in: &cancellables)
        playersViewModel.$data.sink { [weak self] data in
            withAnimation {
                self?.players = data
            }
        }
        .store(in: &cancellables)
        teamsViewModel.$data.sink { [weak self] data in
            withAnimation {
                self?.teams = data
            }
        }
        .store(in: &cancellables)
        playersViewModel.$isBusy.sink { [weak self] isBusy in
            self?.isBusy = isBusy || self?.teamsViewModel.isBusy ?? false
        }
        .store(in: &cancellables)
        teamsViewModel.$isBusy.sink { [weak self] isBusy in
            self?.isBusy = isBusy || self?.playersViewModel.isBusy ?? false
        }
        .store(in: &cancellables)
        playersViewModel.$isCompleted.sink { [weak self] isCompleted in
            withAnimation {
                self?.isPlayersCompleted = isCompleted
            }
        }
        .store(in: &cancellables)
        teamsViewModel.$isCompleted.sink { [weak self] isCompleted in
            withAnimation {
                self?.isTeamsCompeleted = isCompleted
            }
        }
        .store(in: &cancellables)

        playersViewModel.handleError = { [weak self] error in
            print(error)
            if self?.showingAlert ?? false {
                self?.showingAlert = false
            }
            self?.showingAlert = true
        }
        teamsViewModel.handleError = { [weak self] error in
            print(error)
            if self?.showingAlert ?? false {
                self?.showingAlert = false
            }
            self?.showingAlert = true
        }
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
    
    func handleFavorite(player: Player) {
        do {
            if player.favorited {
                FavoritesViewModel.shared.removePlayer(player: player)
                player.favorited = false
            } else {
                try FavoritesViewModel.shared.add(player: player)
                player.favorited = true
            }
        } catch {
            print(error.localizedDescription)
            showingAlert = true
        }
    }
    
    func handleFavorite(team: Team) {
        do {
            if team.favorited {
                FavoritesViewModel.shared.removeTeam(team: team)
                team.favorited = false
            } else {
                try FavoritesViewModel.shared.add(team: team)
                team.favorited = true
            }
        } catch {
            print(error.localizedDescription)
            showingAlert = true
        }
    }
    
}
