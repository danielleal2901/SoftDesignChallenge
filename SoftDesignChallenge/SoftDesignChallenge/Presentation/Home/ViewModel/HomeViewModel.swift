//
//  HomeViewModel.swift
//  SoftDesignChallenge
//
//  Created by ACT on 22/02/22.
//

import Foundation
import RxSwift

protocol HomeViewModel {
  var useCase: GetEventsUseCase {get}
  var events: PublishSubject<[Event]> {get}
  var error: PublishSubject<String> {get}
  func getEvents()
  
  init(useCase: GetEventsUseCase)
}
