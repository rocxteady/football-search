//
//  APIResponse.swift
//  API
//
//  Created by Ulaş Sancak on 10.11.2020.
//

import Foundation
import RestClient

public struct APIResponse<ResponseModel: Decodable> {
    public var responseModel: ResponseModel?
    public var success = false
    public var error: Error?
    public init() {}
}

extension APIResponse {
    
    static func instance(with response: Result<Data, RestError>) -> APIResponse {
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
    
}
