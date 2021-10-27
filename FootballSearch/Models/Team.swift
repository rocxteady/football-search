//
//  Team.swift
//  FootballSearch
//
//  Created by Ulaş Sancak on 23.10.2021.
//

import Foundation
import API

protocol TeamProtocol {
    
    var name :String { get }
    var city: String { get }
    var stadium: String { get }
    
}

class Team: ObservableObject, APIIdentifiable, TeamProtocol, Identifiable {
    
    var id: String {
        teamID
    }
    
    let teamID: String
    let name :String
    let city: String
    let stadium :String
    
    @Published var favorited: Bool = false
    
    init(teamID: String,
         name: String,
         city: String,
         stadium: String) {
        self.teamID = teamID
        self.name = name
        self.city = city
        self.stadium = stadium
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
        name = try container.decode(String.self, forKey: .teamName)
        city = try container.decode(String.self, forKey: .teamCity)
        stadium = try container.decode(String.self, forKey: .teamStadium)
    }
    
}

extension TeamEntity {
    
    convenience init(team: Team) {
        self.init(context: PersistenceController.shared.container.viewContext)
        teamID = team.teamID
        teamName = team.name
        teamCity = team.city
        teamStadium = team.stadium
    }
    
}

extension TeamEntity: TeamProtocol {
    
    var name: String {
        teamName ?? ""
    }
    
    var city: String {
        teamCity ?? ""
    }
    
    var stadium: String {
        teamStadium ?? ""
    }
    
}
