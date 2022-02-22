//
//  GetEventsUseCase.swift
//  SoftDesignChallenge
//
//  Created by ACT on 22/02/22.
//

import Foundation

protocol GetEventsUseCase {
  func getEvents(service: EventRequest, completion: @escaping (Result<[Event], Error>) -> Void)
}
