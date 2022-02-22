//
//  GetEventsUseCaseDefault.swift
//  SoftDesignChallenge
//
//  Created by ACT on 22/02/22.
//

import Foundation

class GetEventsUseCaseDefault: GetEventsUseCase {
  func getEvents(service: EventRequest, completion: @escaping (Result<[Event], Error>) -> Void) {
    NetworkManager.shared.request(service: service, completion: completion)
  }
}
