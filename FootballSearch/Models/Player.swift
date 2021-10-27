//
//  Player.swift
//  FootballSearch
//
//  Created by Ulaş Sancak on 23.10.2021.
//

import Foundation
import API
import CoreData

protocol PlayerProtocol {
    var name: String { get }
    var age: String { get }
    var club: String { get }
    var countryImageName: String? { get }
}

class Player: ObservableObject, APIIdentifiable, PlayerProtocol, Identifiable {
    
    var id: String {
        playerID
    }
    
    let playerID: String
    let playerFirstName: String
    let playerSecondName: String
    let age: String
    let club: String
    let playerNationality: String
    
    var name: String {
        playerFirstName + playerSecondName
    }
    
    var countryImageName: String? {
        FlagName.imageNameBy(nationality: playerNationality)
    }
    
    @Published var favorited: Bool = false
    
    init(playerID: String,
         playerFirstName: String,
         playerSecondName: String,
         age: String,
         club: String,
         playerNationality: String) {
        self.playerID = playerID
        self.playerFirstName = playerFirstName
        self.playerSecondName = playerSecondName
        self.age = age
        self.club = club
        self.playerNationality = playerNationality
    }
    
    enum CodingKeys: String, CodingKey {
        case playerID
        case playerFirstName
        case playerSecondName
        case playerAge
        case playerClub
        case playerNationality
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        playerID = try container.decode(String.self, forKey: .playerID)
        playerFirstName = try container.decode(String.self, forKey: .playerFirstName)
        playerSecondName = try container.decode(String.self, forKey: .playerSecondName)
        age = try container.decode(String.self, forKey: .playerAge)
        club = try container.decode(String.self, forKey: .playerClub)
        playerNationality = try container.decode(String.self, forKey: .playerNationality)
    }
    
}

extension PlayerEntity {
    
    convenience init(player: Player) {
        self.init(context: PersistenceController.shared.container.viewContext)
        playerID = player.playerID
        playerFirstName = player.playerFirstName
        playerSecondName = player.playerSecondName
        playerAge = player.age
        playerClub = player.club
        playerNationality = player.playerNationality
    }
    
}

extension PlayerEntity: PlayerProtocol {
    
    var name: String {
        (playerFirstName ?? "") + (playerSecondName ?? "")
    }
    
    var age: String {
        playerAge ?? ""
    }
    
    var club: String {
        playerClub ?? ""
    }
    
    var countryImageName: String? {
        guard let playerNationality = playerNationality else { return nil }
        return FlagName.imageNameBy(nationality: playerNationality)
    }
    
}
