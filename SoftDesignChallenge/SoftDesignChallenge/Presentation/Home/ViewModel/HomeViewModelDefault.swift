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
  let disposeBag = DisposeBag()
  
  required init(useCase: GetEventsUseCase = GetEventsUseCaseDefault()) {
    self.useCase = useCase
  }
  
  func getEvents() {
    useCase.getEvents(service: EventRequest.getEvents).subscribe { events in
      self.events.onNext(events)
    } onError: { error in
      self.error.onNext((error as? NetworkErrors)?.message ?? "Unknown")
    }.disposed(by: disposeBag)
  }
  
}
