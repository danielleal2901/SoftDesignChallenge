//
//  Encodable+toDict.swift
//  SoftDesignChallenge
//
//  Created by ACT on 22/02/22.
//

import Foundation
extension Encodable {
    var dictionary: [String: Any]? {
        guard let data = try? JSONEncoder().encode(self) else { return nil }
        return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)).flatMap { $0 as? [String: Any] }
    }
}
