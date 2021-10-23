//
//  RestError.swift
//  RestClient
//
//  Created by Ulaş Sancak on 12.03.2020.
//  Copyright © 2020 Ulaş Sancak. All rights reserved.
//

import Foundation

public enum RestError: Error {
    
    case badURL
    case badHost
    case jsonSerialization(error: Error?)
    case urlSession(error: Error?)
    case data(data: Data)
    case cancelled
    case unknown
    
}
