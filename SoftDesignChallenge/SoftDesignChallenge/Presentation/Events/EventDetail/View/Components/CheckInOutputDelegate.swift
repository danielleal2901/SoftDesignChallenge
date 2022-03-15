//
//  CheckInOutputDelegate.swift
//  SoftDesignChallenge
//
//  Created by ACT on 14/03/22.
//

import Foundation

protocol CheckInOutputDelegate: AnyObject {
  func sendCheckIn(name: String, email: String)
}
