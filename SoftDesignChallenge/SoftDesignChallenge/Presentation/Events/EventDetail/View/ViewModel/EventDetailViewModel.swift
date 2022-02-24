//
//  EventDetailViewModel.swift
//  SoftDesignChallenge
//
//  Created by Daniel Leal on 22/02/22.
//

import Foundation
import UIKit

class EventDetailViewModel {
  let event: Event
  
  init(event: Event) {
    self.event = event
  }
  
  var title : String {
    event.title
  }
  
  var description: String {
    event.welcomeDescription
  }
  
  var date: NSMutableAttributedString {
    let attributedString = NSMutableAttributedString()
    .bold(
      boldFont: UIFont(name: "AvenirNextCondensed-DemiBold", size: 13) ??
      UIFont.boldSystemFont(ofSize: 13),
      value: "Data: "
    )
    .normal(
      normalFont: UIFont(name: "AvenirNextCondensed-Medium", size: 12) ??
      UIFont.systemFont(ofSize: 12),
      value: event.getFormattedDate()
    )
    
    return attributedString
  }
  
  var image: UIImage? {
    event.loadedImage
  }
}
