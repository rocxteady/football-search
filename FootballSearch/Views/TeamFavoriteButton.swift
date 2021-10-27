//
//  TeamFavoriteButton.swift
//  FootballSearch
//
//  Created by Ulaş Sancak on 27.10.2021.
//

import SwiftUI

struct TeamFavoriteButton: View {
    
    @ObservedObject var team: Team
    let action: () -> Void

    var body: some View {
        Button(action: action, label: {
            Image(systemName: team.favorited ? "heart.fill" : "heart")
        })
    }
}

struct TeamFavoriteButton_Previews: PreviewProvider {
    static var previews: some View {
        TeamFavoriteButton(team: Team(teamID: "0", name: "Trabzonspor", city: "Trabzon", stadium: "Şenol Güneş"), action: {})
    }
}
