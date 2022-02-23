//
//  EventTableViewCell.swift
//  SoftDesignChallenge
//
//  Created by ACT on 22/02/22.
//

import Foundation
import UIKit
import RxSwift

class EventTableViewCell: UITableViewCell, ViewCodable {
  static let identifier = String(describing: EventTableViewCell.self)
  
  var title: String?
  var imageUrl: String?
  let viewModel = HomeTableViewCellViewModel()
  let disposeBag = DisposeBag()
  
  private lazy var activityIndicator: UIActivityIndicatorView = {
    let activity = UIActivityIndicatorView(style: .medium)
    activity.translatesAutoresizingMaskIntoConstraints = false
    return activity
  }()

  private lazy var eventImage: UIImageView = {
    let image = UIImageView()
    image.contentMode = .scaleAspectFit
    image.translatesAutoresizingMaskIntoConstraints = false
    return image
  }()
  
  private lazy var eventTitle: UILabel = {
    let label = UILabel()
    label.text = title
    label.translatesAutoresizingMaskIntoConstraints = false
    label.numberOfLines = 0
    return label
  }()
  
  required init?(coder aDecoder: NSCoder) {
      super.init(coder: aDecoder)
  }

  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
      super.init(style: style, reuseIdentifier: reuseIdentifier)
  }
  
  func addHierarchy() {
    contentView.addSubview(eventImage)
    contentView.addSubview(eventTitle)
    
    eventImage.addSubview(activityIndicator)
  }
  
  func addConstraints() {
    NSLayoutConstraint.activate([
      eventTitle.leadingAnchor.constraint(equalTo: eventImage.trailingAnchor, constant: 5),
      eventTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
      eventTitle.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
      eventTitle.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
    ])
    
    NSLayoutConstraint.activate([
      eventImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
      eventImage.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.2),
      eventImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
    ])

    NSLayoutConstraint.activate([
      activityIndicator.leadingAnchor.constraint(equalTo: eventImage.leadingAnchor),
      activityIndicator.trailingAnchor.constraint(equalTo: eventImage.trailingAnchor),
      activityIndicator.topAnchor.constraint(equalTo: eventImage.topAnchor),
      activityIndicator.bottomAnchor.constraint(equalTo: eventImage.bottomAnchor)
    ])
  }
  
  func applyAdditionalConfiguration() {
    accessoryType = .disclosureIndicator
  }
  
  func bindUI() {
    viewModel.image.subscribe(onNext: {[weak self] image in
      self?.eventImage.image = image
      self?.activityIndicator.stopAnimating()
      self?.activityIndicator.removeFromSuperview()
    }).disposed(by: disposeBag)

  }
  
  func setup(title: String, imageUrl: String) {
    self.title = title
    self.imageUrl = imageUrl
    
    setupView()
    viewModel.getImage(imageUrl: imageUrl)
    activityIndicator.startAnimating()
  }
}
