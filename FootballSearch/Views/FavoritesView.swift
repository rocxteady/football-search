//
//  FavoritesView.swift
//  FootballSearch
//
//  Created by Ulaş Sancak on 27.10.2021.
//

import SwiftUI

struct FavoritesView: View {
    
    @ObservedObject var viewModel = FavoritesViewModel.shared
    
    var body: some View {
        NavigationView {
            ZStack {
                if viewModel.isEmpty {
                    Text("No Favorites")
                } else {
                    List {
                        if !viewModel.isPlayersEmpty {
                            Section("Players") {
                                ForEach (viewModel.players) { player in
                                    PlayerView(player: player)
                                }
                                .onDelete { indexSet in
                                    viewModel.removePlayer(at: indexSet.first!)
                                }
                            }
                        }
                        if !viewModel.isTeamsEmpty {
                            Section("Teams") {
                                ForEach (viewModel.teams) { team in
                                    TeamView(team: team)
                                }
                                .onDelete { indesSet in
                                    viewModel.removeTeam(at: indesSet.first!)
                                }
                            }
                        }
                    }
                }
            }
            .navigationTitle("Favorites")
        }
    }
}

struct FavoritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesView()
    }
}
