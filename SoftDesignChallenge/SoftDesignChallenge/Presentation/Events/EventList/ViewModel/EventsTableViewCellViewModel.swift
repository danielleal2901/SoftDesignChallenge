//
//  EventsTableViewCellViewModel.swift
//  SoftDesignChallenge
//
//  Created by ACT on 22/02/22.
//

import Foundation
import RxSwift
import UIKit

class EventsTableViewCellViewModel {
  let image = PublishSubject<UIImage>()
  let disposeBag = DisposeBag()
  
  init(){
  }
  
  func getImage(imageUrl: String) {
    let observable: Observable<Data> = NetworkManager.shared.request(service: ImageRequest.getEventImage(path: imageUrl))
    
    observable
      .compactMap({UIImage(data: $0)})
      .bind(to: image)
      .disposed(by: disposeBag)
  }
}
