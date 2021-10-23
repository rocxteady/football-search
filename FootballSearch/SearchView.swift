//
//  SearchView.swift
//  FootballSearch
//
//  Created by Ulaş Sancak on 23.10.2021.
//

import SwiftUI

struct SearchView: View {
    
    @State var searchText: String = ""
    let data = FootballData(players: [Player(id: "0", name: "Ulas", age: "33", club: "Sancak"),
                                      Player(id: "0", name: "Ulas", age: "33", club: "Sancak")], teams: [Team(id: "0", name: "Trabzonspor", city: "Trabzon", stadium: "Şenol Güneş")])
    
    var body: some View {
        NavigationView {
            List {
                if !data.players.isEmpty {
                    Section("Players") {
                        ForEach (data.players) { player in
                            PlayerView(player: player)
                        }
                    }
                }
                if !data.teams.isEmpty {
                    Section("Teams") {
                        ForEach (data.teams) { team in
                            TeamView(team: team)
                        }
                    }
                }
            }
                .searchable(text: $searchText)
                .navigationTitle("Football Search")
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
