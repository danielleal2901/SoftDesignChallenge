//
//  EventDetailView+MapOutputDelegate.swift
//  SoftDesignChallenge
//
//  Created by Daniel Leal on 23/02/22.
//

import Foundation
import UIKit

extension EventDetailView: EventMapViewOutputDelegate {
  func showMapInFullscreen() {
    mapNormalHeightConstraint?.isActive = false
    mapNormalTopConstraint?.isActive = false
    mapFullscreenTopConstraint?.isActive = true
    mapFullscreenBottomConstraint?.isActive = true
    
    outputDelegate?.hideNavigationBar()
    UIView.animate(withDuration: 0.3) {
      self.layoutIfNeeded()
    }
  }
  
  func removeMapFullscreen() {
    mapFullscreenTopConstraint?.isActive = false
    mapFullscreenBottomConstraint?.isActive = false
    mapNormalTopConstraint?.isActive = true
    mapNormalHeightConstraint?.isActive = true

    outputDelegate?.showNavigationBar()
    UIView.animate(withDuration: 0.3) {
      self.layoutIfNeeded()
    }
  }
}
