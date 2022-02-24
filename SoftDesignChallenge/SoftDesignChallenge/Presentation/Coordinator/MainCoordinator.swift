//
//  MainCoordinator.swift
//  SoftDesignChallenge
//
//  Created by Daniel Leal on 22/02/22.
//

import Foundation
import UIKit

class MainCoordinator: Coordinator {
  //MARK: Properties
  var childCoordinators: [Coordinator] = []
  var navigationController: UINavigationController
  
  //MARK: Initializers
  init(navigationController: UINavigationController) {
    self.navigationController = navigationController
  }
  
  //MARK: Methods
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
