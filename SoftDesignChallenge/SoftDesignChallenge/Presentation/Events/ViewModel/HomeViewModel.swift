//
//  HomeViewModel.swift
//  SoftDesignChallenge
//
//  Created by ACT on 22/02/22.
//

import Foundation
import RxSwift

class EventsViewModel {
  let useCase: GetEventsUseCase
  let events = PublishSubject<[Event]>()
  let error = PublishSubject<String>()
  let disposeBag = DisposeBag()
  
  init(useCase: GetEventsUseCase = GetEventsUseCaseDefault()) {
    self.useCase = useCase
  }
  
  func getEvents() {
    useCase.getEvents(service: EventRequest.getEvents)
      .subscribe(onNext: {[weak self] events in
        self?.events.onNext(events)
        self?.events.onCompleted()
      }, onError: {[weak self] error in
        self?.error.onNext((error as? NetworkErrors)?.message ?? "Unknown")
      }).disposed(by: disposeBag)
  }
  
}
