//
//  Player.swift
//  FootballSearch
//
//  Created by Ulaş Sancak on 23.10.2021.
//

import Foundation

struct Player: Decodable, Identifiable {
    
    var id: String {
        return playerID
    }
    
    let playerID: String
    let playerFirstName: String
    let playerSecondName: String
    let playerAge: String
    let playerClub: String
    
    var playerName: String {
        return playerFirstName + playerSecondName
    }
    
}


