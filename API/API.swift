//
//  API.swift
//  API
//
//  Created by Ulaş Sancak on 10.11.2020.
//

import Foundation
import RestClient

public protocol API {
    associatedtype ResponseModel: Decodable
    associatedtype RequestModel: Encodable
    var uri: String { get }
    var endpoint: RestEndpoint { get }
    func start() async -> APIResponse<ResponseModel>
    func end()
}

public extension API {
    func start() async -> APIResponse<ResponseModel> {
        let response = await endpoint.start()
        var apiResponse = APIResponse<ResponseModel>()
        switch response {
        case .success(let data):
            do {
                let baseResponseModel: BaseResponseModel = try data.toDecodable()
                if baseResponseModel.result.status {
                    let responseModel: ResponseModel = try data.toDecodable()
                    apiResponse.responseModel = responseModel
                    apiResponse.success = true
                } else {
                    apiResponse.error = NSError(domain: Properties.domain, code: -1, userInfo: [NSLocalizedDescriptionKey: baseResponseModel.result.message])
                }
            } catch let error {
                apiResponse.error = error
            }
        case .failure(let error):
            apiResponse.error = error
        }
        return apiResponse
    }
    func end() {
        endpoint.end()
    }
}
