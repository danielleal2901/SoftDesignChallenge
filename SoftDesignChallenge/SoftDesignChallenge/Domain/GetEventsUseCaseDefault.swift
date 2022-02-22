//
//  GetEventsUseCaseDefault.swift
//  SoftDesignChallenge
//
//  Created by ACT on 22/02/22.
//

import Foundation
import RxSwift

class GetEventsUseCaseDefault: GetEventsUseCase {
  func getEvents(service: EventRequest) -> Observable<[Event]> {
    return NetworkManager.shared.request(service: service)
  }
}
