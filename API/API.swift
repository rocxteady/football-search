//
//  API.swift
//  API
//
//  Created by Ulaş Sancak on 10.11.2020.
//

import Foundation
import RestClient

public typealias APIResponseCompletion<T: Decodable> = (APIResponse<T>) -> ()

public protocol API {
    associatedtype ResponseModel: Decodable
    associatedtype RequestModel: Encodable
    var uri: String { get }
    var endpoint: RestEndpoint { get }
    func start(completion: @escaping APIResponseCompletion<ResponseModel>)
    func end()
}

public extension API {
    func start(completion: @escaping APIResponseCompletion<ResponseModel>) {
        endpoint.start { (response) in
            var apiResponse = APIResponse<ResponseModel>()
            switch response {
            case .success(let data):
                do {
                    let responseModel: ResponseModel = try data.toDecodable()
                    apiResponse.responseModel = responseModel
                    apiResponse.success = true
                } catch let error {
                    apiResponse.error = error
                }
            case .failure(let error):
                apiResponse.error = error
            }
            completion(apiResponse)
        }
    }
    func end() {
        endpoint.end()
    }
}
