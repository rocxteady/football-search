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

struct BaseResponse<T: APIIdentifiable>: Decodable {
    
    let result: CommonResult<T>
    
}

struct CommonResult<T: APIIdentifiable>: BaseResult {
    
    let status: Bool
    
    let message: String
    
    let data: [T]
        
    enum CodingKeys: String, CodingKey {
        case players
        case teams
        case status
        case message
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        if T.self == Player.self {
            data = try container.decodeIfPresent([T].self, forKey: .players) ?? []
        } else if T.self == Team.self {
            data = try container.decodeIfPresent([T].self, forKey: .teams) ?? []
        } else {
            data = []
        }
        status = try container.decode(Bool.self, forKey: .status)
        message = try container.decode(String.self, forKey: .message)
    }
    
}


struct SearchRequestModel: Encodable {
    
    let searchString: String
        
    let offset: Int
    
    fileprivate var searchType: SearchType = .players
    
    init(searchString: String, offset: Int) {
        self.searchString = searchString
        self.offset = offset
    }
    
}

struct SearchAPI<T: APIIdentifiable>: API {
    
    let uri = "/search"
    
    let endpoint: RestEndpoint
    
    typealias ResponseModel = BaseResponse<T>
    
    typealias RequestModel = SearchRequestModel
    
    init(requestModel: RequestModel) throws {
        var requestModel = requestModel
        if T.self == Team.self {
            requestModel.searchType = .teams
        }
        endpoint = RestEndpoint(urlString: Properties.baseURL + uri, parameters: try requestModel.toDictionary())
    }
    
}
