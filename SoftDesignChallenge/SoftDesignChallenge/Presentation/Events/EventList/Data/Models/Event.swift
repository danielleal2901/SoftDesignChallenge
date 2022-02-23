//
//  Event.swift
//  SoftDesignChallenge
//
//  Created by ACT on 22/02/22.
//

import Foundation
import UIKit

class Event: Decodable, Equatable {
  let people: [String]
  let date: Int
  let welcomeDescription: String
  let image: String
  var loadedImage: UIImage?
  let longitude : Double
  let latitude : Double
  let price: Double
  let title: String
  let id: String
  
  enum CodingKeys: String, CodingKey {
    case people, date, image, longitude, latitude, price, title, id
    case welcomeDescription = "description"
  }
  
  static func ==(lhs: Event, rhs: Event) -> Bool {
      return lhs.id == rhs.id
  }
  
  func setImage(_ image: UIImage){
    self.loadedImage = image
  }
}
