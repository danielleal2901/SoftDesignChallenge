//
//  NetworkErrorsTests.swift
//  SoftDesignChallengeTests
//
//  Created by Daniel Leal on 24/02/22.
//

import Foundation
import XCTest
@testable import SoftDesignChallenge

class NetworkErrorsTests: XCTestCase {
  var sut: NetworkErrors!
  
  override func setUpWithError() throws {
  }
  
  override func tearDownWithError() throws {
  }
  
  func test_NetworkErrors_invalidUrl() {
    sut = .invalidUrl
    
    XCTAssertEqual(sut.message, "URL inválida")
  }
  
  func test_NetworkErrors_decodeError() {
    sut = .decodeError
    
    XCTAssertEqual(sut.message, "Erro na decodificação do objeto")
  }
  
  func test_NetworkErrors_statusCode() {
    let statusCode = 404
    sut = .statusCode(code: statusCode)
    
    XCTAssertEqual(sut.message, "Erro: \(statusCode)")
  }
  
  func test_NetworkErrors_withoutResponseData() {
    sut = .withoutResponseData
    
    XCTAssertEqual(sut.message, "Sem dados na resposta")
  }
}
