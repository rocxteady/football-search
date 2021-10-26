//
//  Player.swift
//  FootballSearch
//
//  Created by Ulaş Sancak on 23.10.2021.
//

import Foundation
import API
import CoreData

class Player: ObservableObject, APIIdentifiable, Identifiable {
    
    var id: String {
        playerID
    }
    
    let playerID: String
    let playerFirstName: String
    let playerSecondName: String
    let playerAge: String
    let playerClub: String
    
    var playerName: String {
        playerFirstName + playerSecondName
    }
    
    @Published var favorited: Bool = false
    
    init(playerID: String,
         playerFirstName: String,
         playerSecondName: String,
         playerAge: String,
         playerClub: String) {
        self.playerID = playerID
        self.playerFirstName = playerFirstName
        self.playerSecondName = playerSecondName
        self.playerAge = playerAge
        self.playerClub = playerClub
    }
    
    enum CodingKeys: String, CodingKey {
        case playerID
        case playerFirstName
        case playerSecondName
        case playerAge
        case playerClub
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        playerID = try container.decode(String.self, forKey: .playerID)
        playerFirstName = try container.decode(String.self, forKey: .playerFirstName)
        playerSecondName = try container.decode(String.self, forKey: .playerSecondName)
        playerAge = try container.decode(String.self, forKey: .playerAge)
        playerClub = try container.decode(String.self, forKey: .playerClub)
    }
    
}

extension PlayerEntity {
    
    convenience init(player: Player) {
        self.init(context: PersistenceController.shared.container.viewContext)
        playerID = player.playerID
        playerFirstName = player.playerFirstName
        playerSecondName = player.playerSecondName
        playerAge = player.playerAge
        playerClub = player.playerClub
    }
    
}
