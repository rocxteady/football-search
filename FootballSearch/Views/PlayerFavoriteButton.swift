//
//  PlayerFavoriteButton.swift
//  FootballSearch
//
//  Created by Ulaş Sancak on 27.10.2021.
//

import SwiftUI

struct PlayerFavoriteButton: View {
    
    @ObservedObject var player: Player
    let action: () -> Void

    var body: some View {
        Button(action: action, label: {
            Image(systemName: player.favorited ? "heart.fill" : "heart")
        })
    }
}

struct PlayerFavoriteButton_Previews: PreviewProvider {
    static var previews: some View {
        PlayerFavoriteButton(player: Player(playerID: "0", playerFirstName: "Ulaş", playerSecondName: "Sancak", age: "33", club: "Sancak"), action: {})
    }
}
