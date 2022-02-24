//
//  EventMapViewOutputDelegate.swift
//  SoftDesignChallenge
//
//  Created by Daniel Leal on 23/02/22.
//

import Foundation
import UIKit

protocol EventMapViewOutputDelegate: AnyObject {
  func showMapInFullscreen()
  func removeMapFullscreen()
}
