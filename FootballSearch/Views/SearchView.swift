//
//  SearchView.swift
//  FootballSearch
//
//  Created by Ulaş Sancak on 23.10.2021.
//

import SwiftUI

struct SearchView: View {
    
    @ObservedObject var viewModel = SearchViewMdoel()
    
    var body: some View {
        NavigationView {
            ZStack {
                if viewModel.shouldShowEmptyView {
                    Text("No Result")
                } else {
                    List {
                        if !viewModel.isPlayersEmpty {
                            Section("Players") {
                                ForEach (viewModel.players) { player in
                                    PlayerView(player: player)
                                }
                                HStack {
                                    Spacer()
                                    Button("More") {
                                        viewModel.morePlayers()
                                    }
                                    Spacer()
                                }
                            }
                        }
                        if !viewModel.isTeamsEmpty {
                            Section("Teams") {
                                ForEach (viewModel.teams) { team in
                                    TeamView(team: team)
                                }
                                HStack {
                                    Spacer()
                                    Button("More") {
                                        viewModel.moreTeams()
                                    }
                                    Spacer()
                                }
                            }
                        }
                    }
                    if viewModel.isBusy {
                        ProgressView()
                    }
                }
            }
            .searchable(text: $viewModel.searchedTextListener.searchedText)
            .navigationTitle("Football Search")
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
