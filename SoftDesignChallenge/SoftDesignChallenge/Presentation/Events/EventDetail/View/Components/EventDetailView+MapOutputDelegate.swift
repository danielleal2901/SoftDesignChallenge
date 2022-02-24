//
//  EventDetailView+MapOutputDelegate.swift
//  SoftDesignChallenge
//
//  Created by ACT on 23/02/22.
//

import Foundation
import UIKit

extension EventDetailView: EventMapViewOutputDelegate {
  func showMapInFullscreen() {
    mapNormalHeightConstraint?.isActive = false
    mapNormalTopConstraint?.isActive = false
    mapFullscreenTopConstraint?.isActive = true
    
    outputDelegate?.hideNavigationBar()
    UIView.animate(withDuration: 0.3) {
      self.layoutIfNeeded()
    }
  }
  
  func removeMapFullscreen() {
    mapFullscreenTopConstraint?.isActive = false
    mapNormalTopConstraint?.isActive = true
    mapNormalHeightConstraint?.isActive = true

    outputDelegate?.showNavigationBar()
    UIView.animate(withDuration: 0.3) {
      self.layoutIfNeeded()
    }
  }
}
