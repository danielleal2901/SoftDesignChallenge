//
//  EventDetail+Constraints.swift
//  SoftDesignChallenge
//
//  Created by ACT on 23/02/22.
//

import Foundation
import UIKit

extension EventDetailView {
  func scrollViewConstraints() -> [NSLayoutConstraint] {
    [
      scrollView.topAnchor.constraint(equalTo: topAnchor),
      scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
      scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
      scrollView.bottomAnchor.constraint(equalTo: bottomAnchor)
    ]
  }
  
  func contentViewConstraints() -> [NSLayoutConstraint] {
    var constraints =   [
      contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
      contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
      contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
      contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
      contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
    ]
    
    let contentHeight = contentView.heightAnchor.constraint(equalTo: scrollView.heightAnchor)
    contentHeight.priority = .defaultLow
    constraints.append(contentHeight)
    
    return constraints
  }
  
  func eventImageConstraints() -> [NSLayoutConstraint] {
    [
      eventImage.topAnchor.constraint(equalTo: contentView.topAnchor),
      eventImage.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
      eventImage.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.3),
      eventImage.heightAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.3)
    ]
  }
  
  func verticalStackConstraints() -> [NSLayoutConstraint] {
    [
      verticalStack.topAnchor.constraint(equalTo: eventImage.bottomAnchor, constant: 20),
      verticalStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30),
      verticalStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30)
    ]
    
  }
  
  func mapConstraints() -> [NSLayoutConstraint] {
    [
      mapView.topAnchor.constraint(greaterThanOrEqualTo: verticalStack.bottomAnchor, constant: 20),
      mapView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
      mapView.heightAnchor.constraint(equalToConstant: 400),
      mapView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
      mapView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10)
    ]
    
  }
}
