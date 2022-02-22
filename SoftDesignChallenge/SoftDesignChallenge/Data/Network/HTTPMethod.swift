//
//  HTTPMethod.swift
//  SoftDesignChallenge
//
//  Created by ACT on 22/02/22.
//

import Foundation

public enum HTTPMethod: String, Equatable {
  case get = "GET"
  case post = "POST"
  case put = "PUT"
  case patch = "PATCH"
  case delete = "DELETE"
}
