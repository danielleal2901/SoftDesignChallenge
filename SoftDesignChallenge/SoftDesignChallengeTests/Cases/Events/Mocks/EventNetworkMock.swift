//
//  EventNetworkMock.swift
//  SoftDesignChallengeTests
//
//  Created by ACT on 24/02/22.
//

import Foundation
import RxSwift
@testable import SoftDesignChallenge

class EventNetworkMock: Network {
  enum ResponseMode {
    case error
    case normal
  }

  var responseMode : ResponseMode = .normal
  
  func request<T>(service: Request) -> Observable<T> where T : Decodable {
    guard let service = service as? EventRequest else { return .error(SearchError.notFound) }
    
    if case .error = responseMode {
      return .error(SearchError.notFound)
    }
    
    return .create { observer in
      do {
        switch service {
        case .getEvents:
          let mockData = try JSONHelper.loadFromFile(name: "events-mock")!
          observer.onNext(try! JSONDecoder().decode(T.self, from: mockData))
        case .getEvent:
          let mockData = try JSONHelper.loadFromFile(name: "event-mock")!
          observer.onNext(try! JSONDecoder().decode(T.self, from: mockData))
        case .checkIn:
          let checkResponse = CheckInResponse(code: "200")
          observer.onNext(checkResponse as! T)
        }
      } catch {
        return Disposables.create()
      }
      return Disposables.create()
    }
    
  }
  
  func request<T>(_ url: URL, method: HTTPMethod, parameters: [String : Any]?, headers: [String : String]?) -> Observable<T> where T : Decodable {
    return .empty()
  }
}
