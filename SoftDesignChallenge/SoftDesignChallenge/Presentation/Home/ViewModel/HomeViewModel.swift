//
//  HomeViewModel.swift
//  SoftDesignChallenge
//
//  Created by ACT on 22/02/22.
//

import Foundation

protocol HomeViewModel {
  var useCase: GetEventsUseCase {get}
  func getEvents()
  
  init(useCase: GetEventsUseCase)
}
