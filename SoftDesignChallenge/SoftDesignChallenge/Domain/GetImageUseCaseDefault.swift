//
//  GetImageUseCaseDefault.swift
//  SoftDesignChallenge
//
//  Created by ACT on 22/02/22.
//

import Foundation
import RxSwift

class GetImageUseCaseDefault: GetImageUseCase {
  func getImage(service: ImageRequest) -> Observable<Data> {
    return NetworkManager.shared.request(service: service)
  }
}
