//
//  ErrorResponseModel.swift
//  API
//
//  Created by Ulaş Sancak on 28.10.2021.
//

import Foundation

struct BaseResponseModel: Decodable {
    
    let result: ErrorResult
    
}

struct ErrorResult: BaseResult {
    
    let status: Bool
    
    let message: String
    
}
