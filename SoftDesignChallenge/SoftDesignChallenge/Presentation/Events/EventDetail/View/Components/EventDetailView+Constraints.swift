//
//  EventDetailView+Constraints.swift
//  SoftDesignChallenge
//
//  Created by Daniel Leal on 23/02/22.
//

import Foundation
import UIKit

extension EventDetailView {
  func scrollViewConstraints() -> [NSLayoutConstraint] {
    [
      scrollView.topAnchor.constraint(equalTo: topAnchor, constant: 30),
      scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
      scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
      scrollView.bottomAnchor.constraint(equalTo: bottomAnchor)
    ]
  }
  
  func contentViewConstraints() -> [NSLayoutConstraint] {
    let constraints =   [
      contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
      contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
      contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
      contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
      contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
    ]
  
    let centerY = contentView.centerYAnchor.constraint(lessThanOrEqualTo: scrollView.centerYAnchor)
    centerY.priority = .defaultHigh
    centerY.isActive = true
    
    let heightAnchor = contentView.heightAnchor.constraint(greaterThanOrEqualTo: scrollView.heightAnchor)
    heightAnchor.priority = .defaultLow
    heightAnchor.isActive = true

    return constraints
  }
  
  func eventImageConstraints() -> [NSLayoutConstraint] {
    [
      eventImage.topAnchor.constraint(equalTo: contentView.topAnchor),
      eventImage.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
      eventImage.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.8),
      eventImage.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.3)
    ]
  }
  
  func verticalStackConstraints() -> [NSLayoutConstraint] {
    [
      verticalStack.topAnchor.constraint(equalTo: eventImage.bottomAnchor, constant: 20),
      verticalStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30),
      verticalStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30),
      dateLabel.widthAnchor.constraint(equalTo: verticalStack.widthAnchor),
    ]
  }

  func mapConstraints() -> [NSLayoutConstraint] {
    let constraints = [
      mapView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
      mapView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
      mapView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
    ]

    mapNormalTopConstraint = mapView.topAnchor.constraint(greaterThanOrEqualTo: verticalStack.bottomAnchor, constant: 30)
    mapNormalTopConstraint?.isActive = true

    mapNormalHeightConstraint = mapView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.3)
    mapNormalHeightConstraint?.isActive = true

    mapFullscreenTopConstraint = mapView.topAnchor.constraint(equalTo: topAnchor)
    return constraints
  }
}
