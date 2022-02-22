//
//  BaseViewController.swift
//  SoftDesignChallenge
//
//  Created by ACT on 22/02/22.
//

import Foundation
import UIKit

class BaseViewController: UIViewController {
  weak var coordinator: Coordinator?
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    print(String(describing: self))
  }

}
