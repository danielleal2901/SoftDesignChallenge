//
//  GetEventsUseCase.swift
//  SoftDesignChallenge
//
//  Created by ACT on 22/02/22.
//

import Foundation
import RxSwift

protocol GetEventsUseCase {
  func getEvents(service: EventRequest) -> Observable<[Event]>
}
