//
//  BaseResponseModel.swift
//  API
//
//  Created by Ulaş Sancak on 11.07.2021.
//

import Foundation

protocol BaseResult: Decodable {
    
    var error: Bool { get }
    var message: String { get }
    
}
