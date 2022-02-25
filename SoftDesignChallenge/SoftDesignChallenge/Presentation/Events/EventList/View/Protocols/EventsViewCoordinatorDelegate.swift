//
//  EventsViewControllerCoordinatorDelegate.swift
//  SoftDesignChallenge
//
//  Created by Daniel Leal on 24/02/22.
//

import Foundation

protocol EventsViewCoordinatorDelegate: AnyObject {
  func showEventDetail(event: Event)
}
