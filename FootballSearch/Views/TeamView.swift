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
                Text(team.name)
                Text("City " + team.city)
                Text("Stadium " + team.stadium)
            }
            Spacer()
        }
    }
}

struct TeamView_Previews: PreviewProvider {
    static var previews: some View {
        TeamView(team: Team(id: "0", name: "Trabzonspor", city: "Trabzon", stadium: "Şenol Güneş"))
    }
}
