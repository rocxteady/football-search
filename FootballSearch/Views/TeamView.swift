//
//  TeamView.swift
//  FootballSearch
//
//  Created by Ulaş Sancak on 23.10.2021.
//

import SwiftUI

struct TeamView: View {
    
    let team: Team
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(team.teamName)
                Text("City " + team.teamCity)
                Text("Stadium " + team.teamStadium)
            }
            Spacer()
        }
    }
}

struct TeamView_Previews: PreviewProvider {
    static var previews: some View {
        TeamView(team: Team(teamID: "0", teamName: "Trabzonspor", teamCity: "Trabzon", teamStadium: "Şenol Güneş"))
    }
}
