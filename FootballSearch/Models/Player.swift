//
//  Player.swift
//  FootballSearch
//
//  Created by Ulaş Sancak on 23.10.2021.
//

import Foundation
import API

struct Player: APIIdentifiable, Identifiable {
    
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


