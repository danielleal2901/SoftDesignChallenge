//
//  EventsViewControllerTests.swift
//  SoftDesignChallengeTests
//
//  Created by Daniel Leal on 24/02/22.
//

import Foundation
import XCTest
@testable import SoftDesignChallenge

class EventsViewControllerTests: XCTestCase {
  var sut: EventsViewController!
  var networkMock: EventNetworkMock!
  var viewModel: EventsViewModel!
  
  override func setUpWithError() throws {
    networkMock = EventNetworkMock()
    viewModel = EventsViewModel(network: networkMock)
    sut = EventsViewController(viewModel: viewModel)
    sut.loadView()
  }
  
  override func tearDownWithError() throws {
    sut = nil
    networkMock = nil
    viewModel = nil
  }
  
  func test_EventsViewController_emptyInitialization() {
    XCTAssertNoThrow(EventsViewController(), "Error in empty initialization")
  }
  
  func test_EventsViewController_layoutConfiguration() {
    XCTAssertTrue(sut.view.subviews.contains(sut.searchBar))
    XCTAssertTrue(sut.view.subviews.contains(sut.tableView))
    XCTAssertTrue(sut.view.subviews.contains(sut.loadingView))
    XCTAssertTrue(sut.view.subviews.contains(sut.errorView))
    XCTAssertTrue(sut.view.subviews.contains(sut.errorView))
    XCTAssertTrue(sut.view.backgroundColor == .white)
    XCTAssertTrue(sut.navigationItem.title == "Eventos")
  }
  
  func test_EventsViewController_showEvents() throws {
    viewModel.getEvents()

    XCTAssertFalse(sut.tableView.isHidden)
    XCTAssertTrue(sut.errorView.isHidden)
    XCTAssertTrue(sut.loadingView.isHidden)
  }
  
  func test_EventsViewController_showError() throws {
    networkMock.responseMode = .error
    
    viewModel.getEvents()
        
    XCTAssertFalse(sut.errorView.isHidden)
    XCTAssertTrue(sut.tableView.isHidden)
    XCTAssertTrue(sut.loadingView.isHidden)
    
  }
  
  func test_EventsViewController_showLoading() throws {
    sut.viewModel.searchObserver.on(.next("Testing..."))
    
    XCTAssertTrue(try sut.viewModel.isLoading.toBlocking().first()!)
    
    XCTAssertFalse(sut.loadingView.isHidden)
    XCTAssertTrue(sut.errorView.isHidden)
    XCTAssertTrue(sut.tableView.isHidden)
  }

}
