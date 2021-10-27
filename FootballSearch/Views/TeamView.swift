//
//  TeamView.swift
//  FootballSearch
//
//  Created by Ulaş Sancak on 23.10.2021.
//

import SwiftUI

struct TeamView: View {
    
    var team: TeamProtocol
    let action: (() -> Void)?
    
    init(team: TeamProtocol,
         action: (() -> Void)? = nil) {
        self.team = team
        self.action = action
    }

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(team.name)
                Text("City " + team.city)
                Text("Stadium " + team.stadium)
            }
            Spacer()
            if let team = team as? Team,
               let action = action {
                TeamFavoriteButton(team: team, action: action)
            }
        }
    }
}

struct TeamView_Previews: PreviewProvider {
    static var previews: some View {
        TeamView(team: Team(teamID: "0", name: "Trabzonspor", city: "Trabzon", stadium: "Şenol Güneş"), action: {})
    }
}
