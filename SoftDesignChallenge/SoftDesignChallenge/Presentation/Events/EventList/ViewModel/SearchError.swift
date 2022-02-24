//
//  SearchError.swift
//  SoftDesignChallenge
//
//  Created by Daniel Leal on 23/02/22.
//

import Foundation

enum SearchError: Error {
  case underlyingError(Error)
  case notFound
  case unknown
  
  var message: String {
    switch self {
    case .underlyingError(let error):
      return error.localizedDescription
    case .notFound:
      return "Event not found"
    case .unknown:
      return "unknown"
    }
    
  }
}
