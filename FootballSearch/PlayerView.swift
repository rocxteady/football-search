//
//  PlayerView.swift
//  FootballSearch
//
//  Created by Ulaş Sancak on 23.10.2021.
//

import SwiftUI

struct PlayerView: View {
    
    let player: Player
    
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
        }
    }
}

struct PlayerView_Previews: PreviewProvider {
    static var previews: some View {
        PlayerView(player: Player(id: "0", name: "Ulaş", age: "33", club: "Trabzonspor"))
    }
}
