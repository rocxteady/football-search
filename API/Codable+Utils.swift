//
//  Codable+Utils.swift
//  API
//
//  Created by Ulaş Sancak on 10.11.2020.
//

import Foundation

public extension Encodable {
    func toDictionary() throws -> [String: AnyObject]? {
        let data = try toData()
        return try JSONSerialization.jsonObject(with: data, options: []) as? [String : AnyObject]
    }
    func toArray() throws -> [AnyObject]? {
        let data = try toData()
        return try JSONSerialization.jsonObject(with: data, options: []) as? [AnyObject]
    }
    func toData() throws -> Data {
        return try JSONEncoder().encode(self)
    }
}
