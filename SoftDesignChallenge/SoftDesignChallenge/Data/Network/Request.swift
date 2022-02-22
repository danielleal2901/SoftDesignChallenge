//
//  Request.swift
//  SoftDesignChallenge
//
//  Created by ACT on 22/02/22.
//

import Foundation

public protocol Request {
  var scheme: String { get }
  var host: String { get }
  var path: String { get }
  var method: HTTPMethod { get }
  var headers: [String: String] { get }
  var params: [String: Any]? { get }
}
