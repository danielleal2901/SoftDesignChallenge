//
//  ImageRequest.swift
//  SoftDesignChallenge
//
//  Created by Daniel Leal on 22/02/22.
//

import Foundation

enum ImageRequest: Request {
  case getEventImage (path: String)
  
  var scheme: String {
    return "http"
  }
  
  var host: String {
    return ""
  }
  
  var path: String {
    if case let .getEventImage(path: imagePath) = self {
      return imagePath
    }
    return ""
  }
  
  var method: HTTPMethod {
    return .get
  }
  
  var headers: [String : String] {
    return [:]
  }
  
  var params: [String : Any]? {
    return nil
  }
  
  
}
