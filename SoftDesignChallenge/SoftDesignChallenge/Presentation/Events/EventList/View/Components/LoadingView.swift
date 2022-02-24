//
//  LoadingView.swift
//  SoftDesignChallenge
//
//  Created by Daniel Leal on 23/02/22.
//

import Foundation
import UIKit

class LoadingView: UIView, ViewCodable {
  //MARK: Layout
  let label: UILabel = {
    let label = UILabel()
    label.text = "Loading..."
    label.textAlignment = .center
    label.font = UIFont(name: "AvenirNextCondensed-Medium", size: 20)
    label.numberOfLines = 0
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  let activityIndicator: UIActivityIndicatorView = {
    let activity = UIActivityIndicatorView(style: .large)
    activity.translatesAutoresizingMaskIntoConstraints = false
    activity.startAnimating()
    return activity
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
    addSubview(activityIndicator)
  }
  
  func addConstraints() {
    NSLayoutConstraint.activate([
      label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
      label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
      label.topAnchor.constraint(equalTo: topAnchor, constant: 10),
      
      activityIndicator.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
      activityIndicator.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
      activityIndicator.heightAnchor.constraint(equalToConstant: 100),
      activityIndicator.topAnchor.constraint(equalTo: label.bottomAnchor),
      activityIndicator.bottomAnchor.constraint(equalTo: bottomAnchor)
    ])
  }
}
