//
//  EventsCoordinatorMock.swift
//  SoftDesignChallengeTests
//
//  Created by ACT on 24/02/22.
//

import Foundation
@testable import SoftDesignChallenge

typealias EventCoordinator = EventsViewCoordinatorDelegate & EventDetailViewCoordinatorDelegate

class EventsCoordinatorMock: EventCoordinator {
  var calledShowEventDetail = false
  var calledDidFinishDetail = false

  func showEventDetail(event: Event) {
    calledShowEventDetail = true
  }
  
  func didFinishDetail() {
    calledDidFinishDetail = true
  }
  
}
