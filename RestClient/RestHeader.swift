//
//  RestHeader.swift
//  RestClient
//
//  Created by Ulaş Sancak on 18.02.2020.
//  Copyright © 2020 Ulaş Sancak. All rights reserved.
//

import Foundation

internal enum HeaderKeys: String {
    case contentType = "Content-Type"
}

internal enum ContentType: String {
    case url    = "application/x-www-form-urlencoded"
    case json   = "application/json"
}
