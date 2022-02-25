//
//  NetworkErrors.swift
//  SoftDesignChallenge
//
//  Created by Daniel Leal on 22/02/22.
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
      return "URL inválida"
    case .decodeError:
      return "Erro na decodificação do objeto"
    case .statusCode(let code):
      return "Erro: \(code)"
    case .withoutResponseData:
      return "Sem dados na resposta"
    }
  }
}
