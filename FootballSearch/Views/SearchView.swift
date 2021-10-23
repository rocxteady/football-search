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
                        if !viewModel.data.players.isEmpty {
                            Section("Players") {
                                ForEach (viewModel.data.players) { player in
                                    PlayerView(player: player)
                                }
                            }
                        }
                        if !viewModel.data.teams.isEmpty {
                            Section("Teams") {
                                ForEach (viewModel.data.teams) { team in
                                    TeamView(team: team)
                                }
                            }
                        }
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
