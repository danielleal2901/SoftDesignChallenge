//
//  EventsTableViewCellViewModel.swift
//  SoftDesignChallenge
//
//  Created by ACT on 22/02/22.
//

import Foundation
import RxSwift
import RxCocoa
import UIKit

class EventsTableViewCellViewModel: ImageRetriever {
  typealias ImageDescriptorType = EventListImage
  
  private let imageSubject = PublishSubject<UIImage>()
  var image: Driver<UIImage> {
    return imageSubject.asDriver(onErrorJustReturn: self.image(.park))
  }
  let disposeBag = DisposeBag()
  
  init(){
  }
  
  func getImage(imageUrl: String) {
    let observable: Observable<Data> = NetworkManager.shared.request(service: ImageRequest.getEventImage(path: imageUrl))
    
    observable
      .compactMap({UIImage(data: $0)})
      .bind(to: imageSubject)
      .disposed(by: disposeBag)
  }
}
