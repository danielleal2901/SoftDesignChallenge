//
//  EventsViewModelTests.swift
//  SoftDesignChallengeTests
//
//  Created by ACT on 24/02/22.
//

import Foundation
import XCTest
import RxTest
import RxSwift
@testable import SoftDesignChallenge

class EventsViewModelTests: XCTestCase {
  var sut: EventsViewModel!
  var scheduler: TestScheduler!
  var disposeBag: DisposeBag!
  
  override func setUpWithError() throws {
    sut = EventsViewModel(network: EventNetworkMock())
    scheduler = TestScheduler(initialClock: 0)
    disposeBag = DisposeBag()
  }
  
  override func tearDownWithError() throws {
    sut = nil
  }
  
  func test_EventViewModels_getEvents() throws {
    let mockData = try JSONHelper.loadFromFile(name: "events-mock")
    let events = try JSONDecoder().decode([SoftDesignChallenge.Event].self, from: mockData!)
    let expectedResultObserver = scheduler.createObserver([SoftDesignChallenge.Event].self)
    
    sut.events
      .drive(expectedResultObserver)
      .disposed(by: disposeBag)
    sut.getEvents()
    
    XCTAssertEqual(expectedResultObserver.events.last?.value.element?.count, events.count)
  }
  
  func test_EventViewModels_searchWithSuccess() {
    let expectedResult = 2
    let expectation = XCTestExpectation(description: "Should receive all events (2)")
    
    sut.events.asObservable()
      .subscribe (onNext: { events in
        XCTAssertEqual(events.count, expectedResult)
        expectation.fulfill()
      }).disposed(by: disposeBag)
    sut.getEvents()
    sut.searchObserver.onNext("Hackathon")
    
    wait(for: [expectation], timeout: 2)
  }
  
  func test_EventViewModels_searchWithError() {
    let expectedResult = SearchError.notFound.message
    let expectation = XCTestExpectation(description: "Should receive error")
    
    sut.error.asObservable()
      .filter({$0 != nil})
      .subscribe(onNext: { error in
        XCTAssertEqual(error?.message, expectedResult)
        expectation.fulfill()
      }).disposed(by: disposeBag)
    sut.getEvents()
    sut.searchObserver.onNext("321")
    
    wait(for: [expectation], timeout: 2)
  }
  
  func test_EventViewModels_searchByEmptyTerm() throws {
    let expectedResult = 2
    let term = ""
    let expectation = XCTestExpectation(description: "Should receive 2 events")
    
    sut.getEvents()
    sut.search(byTerm: term)
      .subscribe(onNext: { events in
        XCTAssertEqual(events.count, expectedResult)
        expectation.fulfill()
      }).disposed(by: disposeBag)
    
    wait(for: [expectation], timeout: 2)
  }
  
  func test_EventViewModels_searchByTerm() throws {
    let expectedResult = "Hackathon"
    let term = "Hacka"
    let expectation = XCTestExpectation(description: "Should receive only hackathon event")

    sut.getEvents()
    sut.search(byTerm: term)
      .subscribe(onNext: { events in
        XCTAssertEqual(events.last?.title, expectedResult)
        expectation.fulfill()
      }).disposed(by: disposeBag)
    
    wait(for: [expectation], timeout: 2)
  }
}
