//
//  NetworkErrors.swift
//  SoftDesignChallenge
//
//  Created by ACT on 22/02/22.
//

import Foundation

enum NetworkErrors: Error {
  case invalidUrl
  case decodeError
  case statusCode (code: Int)
  case withoutResponseData
  
  var message: String {
    switch self {
    case .invalidUrl:
      return "Invalid url"
    case .decodeError:
      return "Decode object error"
    case .statusCode(let code):
      return "Error \(code)"
    case .withoutResponseData:
      return "Without response data"
    }
  }
}
