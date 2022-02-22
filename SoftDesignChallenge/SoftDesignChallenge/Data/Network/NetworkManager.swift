//
//  NetworkManager.swift
//  SoftDesignChallenge
//
//  Created by ACT on 22/02/22.
//

import Foundation

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
    headers: [String: String]? = nil,
    completion: @escaping (Result<T, Error>) -> Void) {
      
      do {
        let request = try setupRequest(url, method: method, parameters: parameters, headers: headers)
        session.dataTask(with: request, completionHandler: {[weak self] data, response, error in
          self?.handleRequest(data: data, response: response, error: error, completion: completion)
        })
        
      } catch {
        completion(.failure(error))
      }
      
    }
  
  public func request<T: Decodable> (
    service: Request,
    completion: @escaping (Result<T, Error>) -> Void) {
      
      guard let url = URL(string: service.path) else {
        completion(.failure(NetworkErrors.invalidUrl))
        return
      }
      
      request(url, method: service.method, parameters: service.params, headers: service.headers, completion: completion)
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
