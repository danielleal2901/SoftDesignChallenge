//
//  EventRequestTests.swift
//  SoftDesignChallengeTests
//
//  Created by ACT on 24/02/22.
//

import Foundation
import XCTest
@testable import SoftDesignChallenge

class EventRequestTests: XCTestCase {
  var sut: EventRequest!
  let host = "http://5f5a8f24d44d640016169133.mockapi.io/api/"
  
  override func setUpWithError() throws {}
  
  override func tearDownWithError() throws {}
  
  func test_ImageRequest_getEvents() {
    sut = EventRequest.getEvents
    
    XCTAssertEqual(sut.scheme, "http")
    XCTAssertEqual(sut.host, host)
    XCTAssertEqual(sut.path, "\(host)events/")
    XCTAssertEqual(sut.method.rawValue, "GET")
    XCTAssertEqual(sut.headers, [:])
    XCTAssertNil(sut.params)
  }

  func test_ImageRequest_getEvent() {
    let id = 1

    sut = EventRequest.getEvent(id: id)
    
    XCTAssertEqual(sut.scheme, "http")
    XCTAssertEqual(sut.host, host)
    XCTAssertEqual(sut.path, "\(host)events/\(id)")
    XCTAssertEqual(sut.method.rawValue, "GET")
    XCTAssertEqual(sut.headers, [:])
    XCTAssertNil(sut.params)
  }
  
  func test_ImageRequest_checkIn() {
    let model = CheckIn(eventId: "1", name: "Test", email: "Test@email.com")
    
    sut = EventRequest.checkIn(model: model)
    
    XCTAssertEqual(sut.scheme, "http")
    XCTAssertEqual(sut.host, host)
    XCTAssertEqual(sut.path, "\(host)checkin")
    XCTAssertEqual(sut.method.rawValue, "POST")
    XCTAssertEqual(sut.headers, [:])
    XCTAssertNotNil(sut.params)
  }
}
