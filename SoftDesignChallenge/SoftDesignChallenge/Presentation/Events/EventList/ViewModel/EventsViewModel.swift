//
//  EventsViewModel.swift
//  SoftDesignChallenge
//
//  Created by Daniel Leal on 22/02/22.
//

import Foundation
import RxSwift
import RxCocoa
import UIKit

class EventsViewModel {
  //MARK: Properties
  private let searchSubject = PublishSubject<String>()
  var searchObserver: AnyObserver<String> {
    return searchSubject.asObserver()
  }
  
  private let errorSubject = PublishSubject<SearchError?>()
  var error: Driver<SearchError?> {
    return errorSubject
      .asDriver(onErrorJustReturn: SearchError.unknown)
  }
  
  private let loadingSubject = PublishSubject<Bool>()
  var isLoading: Driver<Bool> {
    return loadingSubject
      .asDriver(onErrorJustReturn: false)
  }
  
  private let eventsSubject = PublishSubject<[Event]>()
  var events: Driver<[Event]> {
    return eventsSubject
      .asDriver(onErrorJustReturn: [])
  }
  
  var allEvents: [Event] = []
  let disposeBag = DisposeBag()
  
  //MARK: Initializers
  init() {
  }
  
  //MARK: Methods
  func getEvents() {
    let observable: Observable<[Event]> = NetworkManager.shared.request(service: EventRequest.getEvents)
    
    observable.subscribe(onNext: {[weak self] events in
      self?.allEvents = events
      self?.eventsSubject.onNext(events)
      self?.setupSearchObservables()
    }, onError: {[weak self] error in
      self?.errorSubject.onNext(SearchError.underlyingError(error))
    }).disposed(by: disposeBag)
    
  }
  
  func setupSearchObservables() {
    searchSubject
      .asObservable()
      .distinctUntilChanged()
      .debounce(.milliseconds(500), scheduler: MainScheduler.instance)
      .flatMapLatest { [weak self] term -> Observable<[Event]> in
        guard let self = self else { return Observable.empty() }
        
        self.errorSubject.onNext(nil)
        self.loadingSubject.onNext(true)
        return self.search(byTerm: term)
          .catch { [weak self] error -> Observable<[Event]> in
            self?.errorSubject.onNext(SearchError.underlyingError(error))
            return Observable.empty()
          }.debounce(.seconds(1), scheduler: MainScheduler.instance)
      }
      .subscribe(onNext: { [weak self] events in
        self?.loadingSubject.onNext(false)
        if events.isEmpty {
          self?.errorSubject.onNext(SearchError.notFound)
        } else {
          self?.eventsSubject.onNext(events)
        }
      })
      .disposed(by: disposeBag)
  }
  
  func search(byTerm term: String) -> Observable<[Event]> {
    return .create { observer in
      
      if term.isEmpty {
        observer.onNext(self.allEvents)
      }
      else {
        let filteredEvents = self.allEvents.filter { $0.title[$0.title.startIndex] == term[term.startIndex] }
        observer.onNext(filteredEvents)
      }
    
      return Disposables.create()
    }
  }
  
}
