//
//  PlayerView.swift
//  FootballSearch
//
//  Created by Ulaş Sancak on 23.10.2021.
//

import SwiftUI

struct PlayerView: View {
    
    var player: PlayerProtocol
    let action: (() -> Void)?
    
    init(player: PlayerProtocol,
         action: (() -> Void)? = nil) {
        self.player = player
        self.action = action
    }
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(player.name)
                HStack(spacing: 32) {
                    Text("Age " + player.age)
                    Text("Club " + player.club)
                }
            }
            Spacer()
            if let player = player as? Player,
               let action = action{
                PlayerFavoriteButton(player: player, action: action)
            }
        }
    }
}

struct PlayerView_Previews: PreviewProvider {
    static var previews: some View {
        PlayerView(player: Player(playerID: "0", playerFirstName: "Ulaş", playerSecondName: "Sancak", age: "33", club: "Sancak"), action: {})
    }
}
