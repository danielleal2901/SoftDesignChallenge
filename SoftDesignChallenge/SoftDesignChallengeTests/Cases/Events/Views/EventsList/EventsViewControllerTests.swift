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
  
  func test_EventsViewController_coordinatorDelegate() throws {
    let mockData = try JSONHelper.loadFromFile(name: "event-mock")
    let event = try JSONDecoder().decode(Event.self, from: mockData!)
    let coordinator = EventsCoordinatorMock()
    sut.coordinator = coordinator
  
    XCTAssertNoThrow(sut.goEventDetailFlow(event: event))
    
    XCTAssertTrue(coordinator.calledShowEventDetail)
  }
  
  func test_EventsViewController_outputDelegate() throws {
    let mockData = try JSONHelper.loadFromFile(name: "event-mock")
    let event = try JSONDecoder().decode(Event.self, from: mockData!)
    let coordinator = EventsCoordinatorMock()
    sut.coordinator = coordinator
    
    XCTAssertNoThrow(sut.goEventDetailFlow(event: event))
    
    XCTAssertTrue(coordinator.calledShowEventDetail)
  }
}
