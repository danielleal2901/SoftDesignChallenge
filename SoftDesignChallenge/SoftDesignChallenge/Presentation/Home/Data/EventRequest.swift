//
//  EventRequest.swift
//  SoftDesignChallenge
//
//  Created by ACT on 22/02/22.
//

import Foundation

enum EventRequest: Request {
  case getEvents
  case getEvent (id: Int)
  case checkIn (model: CheckIn)
  
  var scheme: String {
    return "http"
  }
  
  var host: String {
    return "http://5f5a8f24d44d640016169133.mockapi.io/api/"
  }
  
  var path: String {
    switch self {
    case .getEvents:
      return "\(host)events/"
    case .getEvent (let id):
      return "\(host)events/\(id)"
    case .checkIn:
      return "\(host)checkin"
    }
  }
  
  var method: HTTPMethod {
    switch self {
    case .getEvents, .getEvent:
      return .get
    case .checkIn:
      return .post
    }
  }
  
  var headers: [String : String] {
    return [:]
  }
  
  var params: [String : Any]? {
    switch self {
    case .getEvents, .getEvent:
      return nil
    case .checkIn(let model):
      return model.dictionary
    }
  }
  
  
}
