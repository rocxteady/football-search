//
//  SearchAPI.swift
//  FootballSearch
//
//  Created by Ulaş Sancak on 24.10.2021.
//

import Foundation
import RestClient
import API

enum SearchType: String, Encodable {
    case players
    case teams
}

struct BaseResponse<T: BaseResult>: Decodable {
    
    let result: T
    
}

struct PlayersResult: BaseResult {
    
    var data: [APIIdentifiable] {
        return players
    }
    
    let players: [Player]
    
    let status: Bool
    
    let message: String
    
    enum CodingKeys: String, CodingKey {
        case players
        case status
        case message
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        players = try values.decodeIfPresent([Player].self, forKey: .players) ?? []
        status = try values.decode(Bool.self, forKey: .status)
        message = try values.decode(String.self, forKey: .message)
    }
    
}

struct TeamsResult: BaseResult {
    
    var data: [APIIdentifiable] {
        return teams
    }
    
    let teams: [Team]
    
    let status: Bool
    
    let message: String
    
    enum CodingKeys: String, CodingKey {
        case teams
        case status
        case message
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        teams = try values.decodeIfPresent([Team].self, forKey: .teams) ?? []
        status = try values.decode(Bool.self, forKey: .status)
        message = try values.decode(String.self, forKey: .message)
    }
    
}

struct SearchRequestModel: Encodable {
    
    let searchString: String
    
    let searchType: SearchType
    
    let offset: Int
    
}

struct SearchAPI<T: BaseResult>: API {
    
    let uri = "/search"
    
    let endpoint: RestEndpoint
    
    typealias ResponseModel = BaseResponse<T>
    
    typealias RequestModel = SearchRequestModel
    
    init(requestModel: RequestModel) throws {
        endpoint = RestEndpoint(urlString: Properties.baseURL + uri, parameters: try requestModel.toDictionary())
    }
    
}
