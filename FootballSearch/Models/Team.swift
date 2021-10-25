//
//  Team.swift
//  FootballSearch
//
//  Created by Ulaş Sancak on 23.10.2021.
//

import Foundation
import API

struct Team: APIIdentifiable, Identifiable {
    
    var id: String {
        teamID
    }
    
    let teamID: String
    let teamName :String
    let teamCity: String
    let teamStadium :String
    
}
