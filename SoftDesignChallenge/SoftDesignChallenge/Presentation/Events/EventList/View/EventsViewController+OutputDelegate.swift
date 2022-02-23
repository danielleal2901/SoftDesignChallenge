//
//  EventsViewController+OutputDelegate.swift
//  SoftDesignChallenge
//
//  Created by ACT on 22/02/22.
//

import Foundation

extension EventsViewController: EventsViewOutputDelegate {
  func goEventDetailFlow(event: Event) {
    (coordinator as? EventsCoordinator)?.showEventDetail(event: event)
  }
}
