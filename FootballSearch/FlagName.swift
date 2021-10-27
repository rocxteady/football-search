//
//  FlagName.swift
//  FootballSearch
//
//  Created by Ulaş Sancak on 27.10.2021.
//

import Foundation

struct FlagName{
    
    private static let flagImageNamesByCountry: [String: String] = [
        "England": "england",
        "Italy": "italy",
        "Germany": "germany",
        "Spain": "spain",
        "Turkey": "turkey",
        "France": "france"
    ]
    
    private static let flagImageNamesByNationality: [String: String] = [
        "English": "england",
        "Italian": "italy",
        "German": "germany",
        "Spanish": "spain",
        "Turkish": "turkey",
        "French": "france"
    ]
    
    static func imageNameBy(country: String) -> String? {
        return flagImageNamesByCountry[country]
    }
    
    static func imageNameBy(nationality: String) -> String? {
        return flagImageNamesByNationality[nationality]
    }

}
