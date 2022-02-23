//
//  HomeTableViewCellViewModel.swift
//  SoftDesignChallenge
//
//  Created by ACT on 22/02/22.
//

import Foundation
import RxSwift
import UIKit

class HomeTableViewCellViewModel {
  let imageUseCase: GetImageUseCase
  let image = PublishSubject<UIImage>()
  let disposeBag = DisposeBag()

  init(imageUseCase: GetImageUseCase = GetImageUseCaseDefault()){
    self.imageUseCase = imageUseCase
  }
  
  func getImage(imageUrl: String) {
    imageUseCase.getImage(service: ImageRequest.getEventImage(path: imageUrl))
      .compactMap({UIImage(data: $0)}).bind(to: image).disposed(by: disposeBag)
  }
}
