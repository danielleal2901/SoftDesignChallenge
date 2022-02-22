//
//  HomeViewModelDefault.swift
//  SoftDesignChallenge
//
//  Created by ACT on 22/02/22.
//

import Foundation
import RxSwift

class HomeViewModelDefault: HomeViewModel {
  let useCase: GetEventsUseCase
  let events = PublishSubject<[Event]>()
  let error = PublishSubject<String>()
  
  required init(useCase: GetEventsUseCase = GetEventsUseCaseDefault()) {
    self.useCase = useCase
  }
  
  func getEvents() {
    useCase.getEvents(service: EventRequest.getEvents) {[weak self] response in
      guard let self = self else { return }
      switch response {
      case .success(let events):
        self.events.onNext(events)
      case .failure(let error):
        if let error = error as? NetworkErrors {
          self.error.onNext(error.message)
        }
      }
    }
  }
  
}
