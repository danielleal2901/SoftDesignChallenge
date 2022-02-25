//
//  EventDetailViewControllerTests.swift
//  SoftDesignChallengeTests
//
//  Created by Daniel Leal on 24/02/22.
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
  
  func test_EventsDetailViewController_layoutConfiguration() {
    XCTAssertTrue(sut.view.subviews.contains(sut.detailView))
    XCTAssertTrue(sut.view.backgroundColor == .white)
    XCTAssertNotNil(sut.navigationItem.leftBarButtonItem)
  }
  
  func test_EventsDetailViewController_coordinatorDelegate() throws {
    let coordinator = EventsCoordinatorMock()
    
    sut.coordinator = coordinator
    
    XCTAssertFalse(coordinator.calledDidFinishDetail)
    XCTAssertNoThrow(sut.leftButtonAction(nil))
    XCTAssertTrue(coordinator.calledDidFinishDetail)
  }
  
  func test_EventsDetailViewController_outputDelegate_hideNavigation() {
    _ = UINavigationController(rootViewController: sut)
    
    XCTAssertNoThrow(sut.hideNavigationBar())
    XCTAssertEqual(sut.navigationController?.navigationBar.isHidden, true)
  }
  
  func test_EventsDetailViewController_outputDelegate_showNavigation() {
    _ = UINavigationController(rootViewController: sut)

    XCTAssertNoThrow(sut.showNavigationBar())
    XCTAssertEqual(sut.navigationController?.navigationBar.isHidden, false)
  }
}
