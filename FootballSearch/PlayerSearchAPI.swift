//
//  SearchAPI.swift
//  FootballSearch
//
//  Created by Ulaş Sancak on 24.10.2021.
//

import Foundation
import RestClient
import API

struct PlayersResponse: Decodable {
    
    let result: PlayersResult
    
}

struct PlayersResult: BaseResult {
    
    let players: [Player]
    
    let status: Bool
    
    let message: String
    
}

struct SearchRequestModel: Encodable {
    
    let searchString: String
    
    let searchType: String
    
    let offset: Int
    
}

struct PlayerSearchAPI: API {
    
    let uri = "/search"
    
    let endpoint: RestEndpoint
    
    typealias ResponseModel = PlayersResponse
    
    typealias RequestModel = SearchRequestModel
    
    init(requestModel: RequestModel) throws {
        endpoint = RestEndpoint(urlString: Properties.baseURL + uri, parameters: try requestModel.toDictionary())
    }
    
}
