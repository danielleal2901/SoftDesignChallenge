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
  
  init(navigationController: UINavigationController) {
    self.navigationController = navigationController
  }
  
  func start() {
    navigationController.pushViewController(createEventsViewController(), animated: true)
  }
  
}

extension EventsCoordinator {
  func createEventsViewController() -> EventsViewController {
    let controller = EventsViewController()
    controller.coordinator = self
    return controller
  }
}
