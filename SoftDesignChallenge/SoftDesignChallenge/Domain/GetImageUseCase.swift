//
//  GetImageUseCase.swift
//  SoftDesignChallenge
//
//  Created by ACT on 22/02/22.
//

import Foundation
import RxSwift

protocol GetImageUseCase {
  func getImage(service: ImageRequest) -> Observable<Data>
}
