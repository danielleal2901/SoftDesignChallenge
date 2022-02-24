//
//  EventDetailViewModel.swift
//  SoftDesignChallenge
//
//  Created by Daniel Leal on 22/02/22.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

fileprivate enum Constants {
  static let date = "Data: "
  static let checkInError = "Erro ao fazer checkIn"
  static let checkInSuccess = "Sucesso ao fazer checkIn"
  static let invalidParameters = "Preencha os campos corretamente"
}

public typealias CheckInResult = (success: Bool, message: String)
class EventDetailViewModel {
  //MARK: Properties
  let event: Event
  let network: Network
  let disposeBag = DisposeBag()
    
  private let checkInSubject = PublishSubject<CheckInResult>()
  var checkInResponse: Driver<CheckInResult> {
    return checkInSubject
      .asDriver(onErrorJustReturn: (false, ""))
  }

  var title : String {
    event.title
  }
  
  var description: String {
    event.welcomeDescription
  }
  
  var date: NSMutableAttributedString {
    let attributedString = NSMutableAttributedString()
    .bold(
      boldFont: UIFont(name: "AvenirNextCondensed-DemiBold", size: 13) ??
      UIFont.boldSystemFont(ofSize: 13),
      value: Constants.date
    )
    .normal(
      normalFont: UIFont(name: "AvenirNextCondensed-Medium", size: 12) ??
      UIFont.systemFont(ofSize: 12),
      value: event.getFormattedDate()
    )
    
    return attributedString
  }
  
  var image: UIImage? {
    event.loadedImage
  }
  
  //MARK: Initializers
  init(event: Event, network: Network = NetworkManager.shared) {
    self.event = event
    self.network = network
  }
  
  //MARK: Methods
  func sendCheckin(name: String, email: String) {
    guard validateName(name), validateEmail(email) else {
      checkInSubject.onNext((false, Constants.invalidParameters))
      return
    }
    
    let observable: Observable<CheckInResponse> = network.request(service: EventRequest.checkIn(model: CheckIn(eventId: event.id, name: name, email: email)))
    observable.subscribe(onNext: {[weak self] _ in
        self?.checkInSubject.onNext((true, Constants.checkInSuccess))
    }, onError: {[weak self] error in
      self?.checkInSubject.onNext((false, Constants.checkInError))
    }).disposed(by: disposeBag)
  }
  
  private func validateName(_ name: String) -> Bool {
    return !name.isEmpty
  }
  
  private func validateEmail(_ email: String) -> Bool {
    return email.isValidEmail()
  }
}


