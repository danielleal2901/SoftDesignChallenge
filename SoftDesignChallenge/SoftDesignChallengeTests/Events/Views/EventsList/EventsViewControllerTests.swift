//
//  EventsViewControllerTests.swift
//  SoftDesignChallengeTests
//
//  Created by ACT on 24/02/22.
//

import Foundation
import XCTest
@testable import SoftDesignChallenge

class EventsViewControllerTests: XCTestCase {
  var sut: EventsViewController!
  
  override func setUpWithError() throws {
    let viewModelMock = EventsViewModel(network: EventNetworkMock())
    sut = EventsViewController(viewModel: viewModelMock)
  }
  
  override func tearDownWithError() throws {
    sut = nil
  }
  
  func test_EventsViewController_emptyInitialization() {
    XCTAssertNoThrow(EventsViewController(), "Error in empty initialization")
  }
  
  func test_EventsViewController_layoutConfiguration() {
    XCTAssertTrue(sut.view.subviews.contains(sut.eventsView))
    XCTAssertTrue(sut.view.backgroundColor == .white)
    XCTAssertTrue(sut.navigationItem.title == "Events Finder")
  }
}
