//
//  EventsViewTests.swift
//  SoftDesignChallengeTests
//
//  Created by ACT on 24/02/22.
//

import Foundation
import XCTest
import RxBlocking

@testable import SoftDesignChallenge

class EventsViewTests: XCTestCase {
  var sut: EventsView!
  
  override func setUpWithError() throws {
    let viewModelMock = EventsViewModel(network: EventNetworkMock())
    sut = EventsView(viewModel: viewModelMock)
  }
  
  override func tearDownWithError() throws {
    sut = nil
  }
  
  func test_EventsView_layoutElementsCreated() {
    XCTAssertTrue(sut.subviews.contains(sut.searchBar))
    XCTAssertTrue(sut.subviews.contains(sut.tableView))
    XCTAssertTrue(sut.subviews.contains(sut.loadingView))
    XCTAssertTrue(sut.subviews.contains(sut.errorView))
  }
  
  func test_EventsView_showEvents() throws {
    let networkMock = EventNetworkMock()
    networkMock.responseMode = .normal
    let viewModel = EventsViewModel(network: networkMock)
    sut = EventsView(viewModel: viewModel)
    
    viewModel.getEvents()

    XCTAssertFalse(sut.tableView.isHidden)
    XCTAssertTrue(sut.errorView.isHidden)
    XCTAssertTrue(sut.loadingView.isHidden)
  }
  
  func test_EventsView_showError() throws {
    let networkMock = EventNetworkMock()
    networkMock.responseMode = .error
    let viewModel = EventsViewModel(network: networkMock)
    sut = EventsView(viewModel: viewModel)
    
    viewModel.getEvents()

    XCTAssertFalse(sut.errorView.isHidden)
    XCTAssertTrue(sut.tableView.isHidden)
    XCTAssertTrue(sut.loadingView.isHidden)
  }
  
  func test_EventsView_showLoading() throws {
    sut.viewModel.searchObserver.on(.next("Testing..."))
    
    XCTAssertTrue(try sut.viewModel.isLoading.toBlocking().first()!)
    
    XCTAssertFalse(sut.loadingView.isHidden)
    XCTAssertTrue(sut.errorView.isHidden)
    XCTAssertTrue(sut.tableView.isHidden)
  }
  
  func test_EventsViewController_outputDelegate() throws {
    let mockDelegate = EventsViewOutputMock()
    let mockData = try JSONHelper.loadFromFile(name: "event-mock")
    
    XCTAssertFalse(mockDelegate.goEventFlow)
    sut.outputDelegate = mockDelegate
    let event = try JSONDecoder().decode(Event.self, from: mockData!)
    sut.outputDelegate?.goEventDetailFlow(event: event)
    
    XCTAssertTrue(mockDelegate.goEventFlow)
  }
}
