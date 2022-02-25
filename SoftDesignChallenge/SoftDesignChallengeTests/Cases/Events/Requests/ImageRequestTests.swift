//
//  ImageRequestTests.swift
//  SoftDesignChallengeTests
//
//  Created by ACT on 24/02/22.
//

import Foundation
import XCTest
@testable import SoftDesignChallenge

class ImageRequestTests: XCTestCase {
  var sut: ImageRequest!
  
  override func setUpWithError() throws {
  }
  
  override func tearDownWithError() throws {
  }
  
  func test_ImageRequest_getEventImage() {
    let path = "/path/"
    sut = ImageRequest.getEventImage(path: path)
    
    XCTAssertEqual(sut.scheme, "http")
    XCTAssertEqual(sut.host, "")
    XCTAssertEqual(sut.path, path)
    XCTAssertEqual(sut.method.rawValue, "GET")
    XCTAssertEqual(sut.headers, [:])
    XCTAssertNil(sut.params)
  }
}

