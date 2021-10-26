//
//  Team.swift
//  FootballSearch
//
//  Created by Ulaş Sancak on 23.10.2021.
//

import Foundation
import API

class Team: ObservableObject, APIIdentifiable, Identifiable {
    
    var id: String {
        teamID
    }
    
    let teamID: String
    let teamName :String
    let teamCity: String
    let teamStadium :String
    
    @Published var favorited: Bool = false
    
    init(teamID: String,
         teamName: String,
         teamCity: String,
         teamStadium: String) {
        self.teamID = teamID
        self.teamName = teamName
        self.teamCity = teamCity
        self.teamStadium = teamStadium
    }
    
    enum CodingKeys: String, CodingKey {
        case teamID
        case teamName
        case teamCity
        case teamStadium
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        teamID = try container.decode(String.self, forKey: .teamID)
        teamName = try container.decode(String.self, forKey: .teamName)
        teamCity = try container.decode(String.self, forKey: .teamCity)
        teamStadium = try container.decode(String.self, forKey: .teamStadium)
    }
    
}

extension TeamEntity {
    
    convenience init(team: Team) {
        self.init(context: PersistenceController.shared.container.viewContext)
        teamID = team.teamID
        teamName = team.teamName
        teamCity = team.teamCity
        teamStadium = team.teamStadium
    }
    
}
