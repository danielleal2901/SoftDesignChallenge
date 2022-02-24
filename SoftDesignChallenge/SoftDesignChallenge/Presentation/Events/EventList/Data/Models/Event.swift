//
//  Event.swift
//  SoftDesignChallenge
//
//  Created by ACT on 22/02/22.
//

import Foundation
import UIKit

class Event: Decodable {
  let people: [String]
  let timestamp: Int
  let welcomeDescription: String
  let image: String
  var loadedImage: UIImage?
  let longitude : Double
  let latitude : Double
  let price: Double
  let title: String
  let id: String
  let date: Date
  
  enum CodingKeys: String, CodingKey {
    case people, image, longitude, latitude, price, title, id
    case timestamp = "date"
    case welcomeDescription = "description"
  }
  
  required init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)
    people = try values.decode([String].self, forKey: .people)
    timestamp = try values.decode(Int.self, forKey: .timestamp)
    welcomeDescription = try values.decode(String.self, forKey: .welcomeDescription)
    image = try values.decode(String.self, forKey: .image)
    longitude = try values.decode(Double.self, forKey: .longitude)
    latitude = try values.decode(Double.self, forKey: .latitude)
    price = try values.decode(Double.self, forKey: .price)
    title = try values.decode(String.self, forKey: .title)
    id = try values.decode(String.self, forKey: .id)
    
    let epochTime = TimeInterval(timestamp) / 1000
    date = Date(timeIntervalSince1970: epochTime)
  }
  
  func setImage(_ image: UIImage){
    self.loadedImage = image
  }
  
  func getFormattedDate() -> String {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    return formatter.string(from: date)
  }
}

extension Event: Equatable {
  static func ==(lhs: Event, rhs: Event) -> Bool {
    return lhs.id == rhs.id
  }
}
