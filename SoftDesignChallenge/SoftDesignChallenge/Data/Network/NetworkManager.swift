//
//  NetworkManager.swift
//  SoftDesignChallenge
//
//  Created by ACT on 22/02/22.
//

import Foundation
import RxSwift
import RxCocoa

final class NetworkManager {
  //MARK: Variables
  private let session: URLSession
  public static let shared = NetworkManager()
  
  //MARK: Initializers
  private init () {
    self.session = URLSession.shared
  }
  
  //MARK: Methods
  public func request<T: Decodable> (
    _ url: URL,
    method: HTTPMethod = .get,
    parameters: [String: Any]? = nil,
    headers: [String: String]? = nil) -> Observable<T> {
      
      return .create { observer in
        do {
          let request = try self.setupRequest(url, method: method, parameters: parameters, headers: headers)
          return URLSession.shared.rx.data(request: request)
          .map { data in
              try JSONDecoder().decode(T.self, from: data)
          }
          .observe(on: MainScheduler.asyncInstance)
          .bind(to: observer)
        } catch {
          observer.onError(error)
        }
        
        return Disposables.create()
      }
    }
  
  public func request<T: Decodable> (
    service: Request) -> Observable<T> {
      
      guard let url = URL(string: service.path) else {
        return Observable<T>.error(NetworkErrors.invalidUrl)
      }
      
      return request(url, method: service.method, parameters: service.params, headers: service.headers)
    }
  
  
  private func setupRequest(
    _ url: URL,
    method: HTTPMethod = .get,
    parameters: [String: Any]? = nil,
    headers: [String: String]? = nil) throws -> URLRequest {
      
      var request = URLRequest(url: url)
      request.httpMethod = method.rawValue
      request.allHTTPHeaderFields = headers
      if let parameters = parameters {
        request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
      }
      
      return request
      
    }
  
  private func handleRequest<T: Decodable>(data: Data?, response: URLResponse?, error: Error?, completion: @escaping (Result<T, Error>) -> Void){
    if let error = error{
      return completion(.failure(error))
    }
    else {
      if let httpResponse = response as? HTTPURLResponse {
        if (200...299).contains(httpResponse.statusCode) {
          if let data = data {
            do {
              let entity = try JSONDecoder().decode(T.self, from: data)
              completion(.success(entity))
            } catch {
              completion(.failure(NetworkErrors.decodeError))
            }
          } else {
            completion(.failure(NetworkErrors.withoutResponseData))
          }
        } else {
          completion(.failure(NetworkErrors.statusCode(code: httpResponse.statusCode)))
        }
      }
    }
  }
  
}
