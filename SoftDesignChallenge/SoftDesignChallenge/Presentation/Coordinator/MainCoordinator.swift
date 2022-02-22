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
    navigationController.pushViewController(createHomeViewController(), animated: true)
  }
  
}

extension MainCoordinator {
  func createHomeViewController() -> HomeViewController {
    let controller = HomeViewController()
    controller.coordinator = self
    return controller
  }
}
