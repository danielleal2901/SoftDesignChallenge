//
//  EventsViewControllerCoordinatorDelegate.swift
//  SoftDesignChallenge
//
//  Created by ACT on 24/02/22.
//

import Foundation

protocol EventsViewCoordinatorDelegate: AnyObject {
  func showEventDetail(event: Event)
}
