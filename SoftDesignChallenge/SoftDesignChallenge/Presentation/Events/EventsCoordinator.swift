//
//  HomeCoordinator.swift
//  SoftDesignChallenge
//
//  Created by ACT on 22/02/22.
//

import Foundation
import UIKit

class EventsCoordinator: Coordinator {
  var childCoordinators: [Coordinator] = []
  var navigationController: UINavigationController
  weak var delegate: EventsCoordinatorDelegate?
  
  init(navigationController: UINavigationController) {
    self.navigationController = navigationController
  }
  
  func start() {
    navigationController.pushViewController(showEventsView(), animated: true)
  }
  
  func finish() {
    delegate?.didFinishEventsFlow()
  }
  
}

extension EventsCoordinator {
  func showEventsView() -> EventsViewController {
    let controller = EventsViewController()
    controller.coordinator = self
    return controller
  }
  
  func showEventDetail(event: Event) {
    let controller = EventDetailViewController(event: event)
    controller.coordinator = self
    navigationController.pushViewController(controller, animated: true)
  }
    
  func didFinishDetail() {
    navigationController.popViewController(animated: true)
  }
}
