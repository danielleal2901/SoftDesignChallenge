//
//  SearchErrorView.swift
//  SoftDesignChallenge
//
//  Created by ACT on 23/02/22.
//

import Foundation
import UIKit
import RxCocoa
import RxSwift

class SearchErrorView: UIView, ViewCodable, ImageRetriever {
  typealias ImageDescriptorType = EventListImage
  
  //MARK: Properties
  var errorMessage: SearchError? {
    didSet {
      label.text = errorMessage?.message
    }
  }
    
  //MARK: Layout
  let label: UILabel = {
    let label = UILabel()
    label.font = UIFont(name: "AvenirNextCondensed-Medium", size: 15)
    label.numberOfLines = 0
    label.textAlignment = .center
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  lazy var errorImage: UIImageView = {
    let image = UIImageView(image: image(.warning))
    image.contentMode = .scaleAspectFit
    image.translatesAutoresizingMaskIntoConstraints = false
    image.layer.cornerRadius = 10.0
    image.layer.masksToBounds = true
    image.clipsToBounds = true
    return image
  }()
  
  //MARK: Initializers
  init() {
    super.init(frame: .zero)
    
    setupView()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  //MARK: Methods
  func addHierarchy() {
    addSubview(label)
    addSubview(errorImage)
  }
  
  func addConstraints() {
    NSLayoutConstraint.activate([
      label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
      label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
      label.topAnchor.constraint(equalTo: topAnchor, constant: 10),
      
      errorImage.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 10),
      errorImage.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
      errorImage.centerXAnchor.constraint(equalTo: centerXAnchor),
      errorImage.widthAnchor.constraint(equalToConstant: 40),
      errorImage.heightAnchor.constraint(equalToConstant: 40)
    ])
  }
}

extension Reactive where Base: SearchErrorView {
  var error: Binder<SearchError?> {
    return Binder(base) { base, value in
      base.errorMessage = value
    }
  }
}
