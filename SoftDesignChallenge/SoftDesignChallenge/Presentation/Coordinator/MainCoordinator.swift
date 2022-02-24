//
//  MainCoordinator.swift
//  SoftDesignChallenge
//
//  Created by ACT on 22/02/22.
//

import Foundation
import UIKit

class MainCoordinator: Coordinator {
  var childCoordinators: [Coordinator] = []
  var navigationController: UINavigationController
  
  init(navigationController: UINavigationController) {
    self.navigationController = navigationController
  }
  
  func start() {
    startEventsFlow()
  }
  
  func finish() {}
}

extension MainCoordinator: EventsCoordinatorDelegate {
  func startEventsFlow() {
    let coordinator = EventsCoordinator(navigationController: navigationController)
    childCoordinators.append(coordinator)
    
    coordinator.start()
  }
  
  func didFinishEventsFlow() {
    navigationController.popToRootViewController(animated: true)
    childCoordinators.removeAll(where: {$0 is EventsCoordinator})
  }
}
