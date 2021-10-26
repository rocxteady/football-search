//
//  PlayerView.swift
//  FootballSearch
//
//  Created by Ulaş Sancak on 23.10.2021.
//

import SwiftUI

struct PlayerView: View {
    
    @ObservedObject var player: Player
    let action: () -> Void
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(player.playerName)
                HStack(spacing: 32) {
                    Text("Age " + player.playerAge)
                    Text("Club " + player.playerClub)
                }
            }
            Spacer()
            Button(action: action, label: {
                Image(systemName: player.favorited ? "heart.fill" : "heart")
            })
        }
    }
}

struct PlayerView_Previews: PreviewProvider {
    static var previews: some View {
        PlayerView(player: Player(playerID: "0", playerFirstName: "Ulaş", playerSecondName: "Sancak", playerAge: "33", playerClub: "Sancak"), action: {})
    }
}
