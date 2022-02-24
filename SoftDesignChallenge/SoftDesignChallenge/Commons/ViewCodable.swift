//
//  ViewCodable.swift
//  SoftDesignChallenge
//
//  Created by Daniel Leal on 22/02/22.
//

import Foundation
import UIKit

protocol ViewCodable {
  func setupView()
  func addHierarchy()
  func addConstraints()
  func applyAdditionalConfiguration()
  func bindUI()
}

extension ViewCodable {
  func setupView() {
    addHierarchy()
    addConstraints()
    applyAdditionalConfiguration()
    bindUI()
  }
  
  func addHierarchy(){}
  func addConstraints(){}
  func applyAdditionalConfiguration(){}
  func bindUI(){}
}
