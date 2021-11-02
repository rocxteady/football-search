//
//  API.swift
//  API
//
//  Created by Ulaş Sancak on 10.11.2020.
//

public typealias APIResponseCompletion<T: Decodable> = (APIResponse<T>) -> ()

import Foundation
import RestClient

public protocol API {
    associatedtype ResponseModel: Decodable
    associatedtype RequestModel: Encodable
    var uri: String { get }
    var endpoint: RestEndpoint { get }
    func start() async -> APIResponse<ResponseModel>
    func start(completion: @escaping APIResponseCompletion<ResponseModel>)
    func end()
}

public extension API {
    
    func start(completion: @escaping APIResponseCompletion<ResponseModel>) {
        endpoint.start { (response) in
            completion(APIResponse.instance(with: response))
        }
    }
    
    func start() async -> APIResponse<ResponseModel> {
        let response = await endpoint.start()
        return APIResponse<ResponseModel>.instance(with: response)
    }
    
    func end() {
        endpoint.end()
    }
    
}
