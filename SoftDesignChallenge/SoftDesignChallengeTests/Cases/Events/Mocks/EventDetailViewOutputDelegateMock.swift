//
//  EventDetailViewOutputDelegateMock.swift
//  SoftDesignChallengeTests
//
//  Created by ACT on 24/02/22.
//

import Foundation
@testable import SoftDesignChallenge

class EventDetailViewOutputDelegateMock: EventDetailViewOutputDelegate {
  var navigationIsHidden = false

  func showNavigationBar() {
    navigationIsHidden = false
  }
  
  func hideNavigationBar() {
    navigationIsHidden = true
  }
}
