//
//  MainCoordinatorTests.swift
//  SoftDesignChallengeTests
//
//  Created by ACT on 24/02/22.
//

import Foundation
import XCTest
@testable import SoftDesignChallenge

class MainCoordinatorTests: XCTestCase {
  var sut: MainCoordinator!
  
  override func setUpWithError() throws {
    sut = MainCoordinator(navigationController: UINavigationController())
  }
  
  override func tearDownWithError() throws {
    sut = nil
  }
  
  func test_MainCoordinator_start() {
    sut.start()
    
    XCTAssertTrue(sut.childCoordinators.contains(where: {$0 is EventsCoordinator}))
    XCTAssertFalse(sut.navigationController.viewControllers.isEmpty)
  }
  
  func test_MainCoordinator_startEventsFlow() {
    sut.startEventsFlow()
    
    XCTAssertTrue(sut.childCoordinators.contains(where: {$0 is EventsCoordinator}))
    XCTAssertFalse(sut.navigationController.viewControllers.isEmpty)
  }
  
  func test_MainCoordinator_didFinishEventsFlow() {
    sut.didFinishEventsFlow()
    
    XCTAssertFalse(sut.childCoordinators.contains(where: {$0 is EventsCoordinator}))
    XCTAssertTrue(sut.navigationController.viewControllers.isEmpty)
  }
}
