//
//  EventsViewOutputMock.swift
//  SoftDesignChallengeTests
//
//  Created by ACT on 24/02/22.
//

import Foundation

@testable import SoftDesignChallenge

class EventsViewOutputMock: EventsViewOutputDelegate {
  var goEventFlow = false
  
  func goEventDetailFlow(event: Event) {
    goEventFlow = true
  }
}
