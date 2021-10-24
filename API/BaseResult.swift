//
//  BaseResponseModel.swift
//  API
//
//  Created by Ulaş Sancak on 11.07.2021.
//

import Foundation

public protocol BaseResult: Decodable {
    
    var status: Bool { get }
    var message: String { get }
    
}
