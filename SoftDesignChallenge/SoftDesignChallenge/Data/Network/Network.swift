//
//  Network.swift
//  SoftDesignChallenge
//
//  Created by Daniel Leal on 24/02/22.
//

import Foundation
import RxSwift

protocol Network {
   func request<T: Decodable> (
    _ url: URL,
    method: HTTPMethod,
    parameters: [String: Any]?,
    headers: [String: String]?) -> Observable<T>
  
   func request<T: Decodable> (service: Request) -> Observable<T>
}
