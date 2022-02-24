//
//  EventDetailViewControllerTests.swift
//  SoftDesignChallengeTests
//
//  Created by ACT on 24/02/22.
//

import Foundation
import XCTest
@testable import SoftDesignChallenge

class EventDetailViewControllerTests: XCTestCase {
  var sut: EventDetailViewController!
  
  override func setUpWithError() throws {
    let mockData = try JSONHelper.loadFromFile(name: "event-mock")
    let event = try JSONDecoder().decode(Event.self, from: mockData!)
    
    sut = EventDetailViewController(event: event)
  }
  
  override func tearDownWithError() throws {
    sut = nil
  }
  
  func test_EventsViewController_layoutConfiguration() {
    XCTAssertTrue(sut.view.subviews.contains(sut.detailView))
    XCTAssertTrue(sut.view.backgroundColor == .white)
    XCTAssertNotNil(sut.navigationItem.leftBarButtonItem)
  }

}
