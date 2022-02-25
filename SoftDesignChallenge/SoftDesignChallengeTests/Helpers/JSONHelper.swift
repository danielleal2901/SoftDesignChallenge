//
//  JSONHelper.swift
//  SoftDesignChallengeTests
//
//  Created by Daniel Leal on 24/02/22.
//

import Foundation

class JSONHelper {
  static func loadFromFile(name: String) throws -> Data? {
    if let path = Bundle(for: self).path(forResource: name, ofType: "json") {
      let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
      return data
    }
    
    return nil
  }
}


