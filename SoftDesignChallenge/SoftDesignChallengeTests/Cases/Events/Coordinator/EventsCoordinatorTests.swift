//
//  EventsCoordinatorTests.swift
//  SoftDesignChallengeTests
//
//  Created by Daniel Leal on 24/02/22.
//

import Foundation
import XCTest
@testable import SoftDesignChallenge

class EventsCoordinatorTests: XCTestCase {
  var sut: EventsCoordinator!
  
  override func setUpWithError() throws {
    sut = EventsCoordinator(navigationController: UINavigationController())
  }
  
  override func tearDownWithError() throws {
    sut = nil
  }
  
  func test_MainCoordinator_start() {
    sut.start()
    
    XCTAssertTrue(sut.navigationController.viewControllers.last is EventsViewController)
  }
  
  func test_MainCoordinator_showEventDetail() throws {
    let mockData = try JSONHelper.loadFromFile(name: "event-mock")
    let event = try JSONDecoder().decode(Event.self, from: mockData!)
    
    sut.showEventDetail(event: event)
    
    XCTAssertTrue(sut.navigationController.viewControllers.last is EventDetailViewController)
  }
  
  func test_MainCoordinator_didFinishDetail() {
    sut.didFinishDetail()

    XCTAssertFalse(sut.navigationController.viewControllers.contains(where: {$0 is EventDetailViewController} ))
  }
}
