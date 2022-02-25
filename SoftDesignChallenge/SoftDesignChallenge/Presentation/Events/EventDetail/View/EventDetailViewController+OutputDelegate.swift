//
//  EventDetailViewController+OutputDelegate.swift
//  SoftDesignChallenge
//
//  Created by Daniel Leal on 23/02/22.
//

import Foundation

extension EventDetailViewController: EventDetailViewOutputDelegate {
  func hideNavigationBar() {
    self.navigationController?.setNavigationBarHidden(true, animated: false)
  }
  
  func showNavigationBar() {
    self.navigationController?.setNavigationBarHidden(false, animated: false)
  }
}
