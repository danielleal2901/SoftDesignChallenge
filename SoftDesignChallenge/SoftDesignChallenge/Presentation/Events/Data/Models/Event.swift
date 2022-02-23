//
//  Event.swift
//  SoftDesignChallenge
//
//  Created by ACT on 22/02/22.
//

import Foundation

struct Event: Decodable {
  let people: [String]
  let date: Int
  let welcomeDescription: String
  let image: String
  let longitude : Double
  let latitude : Double
  let price: Double
  let title: String
  let id: String
  
  enum CodingKeys: String, CodingKey {
    case people, date, image, longitude, latitude, price, title, id
    case welcomeDescription = "description"
  }
}
