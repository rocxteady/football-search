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
            countryImage
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 25)
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
    
    private var countryImage: Image {
        if let imageName = player.countryImageName {
            return Image(imageName)
        } else {
            return Image(systemName: "rectangle.slash")
        }
    }
    
}

struct PlayerView_Previews: PreviewProvider {
    static var previews: some View {
        PlayerView(player: Player(playerID: "0", playerFirstName: "Ulaş", playerSecondName: "Sancak", age: "33", club: "Sancak", playerNationality: "Turkey"), action: {})
    }
}
