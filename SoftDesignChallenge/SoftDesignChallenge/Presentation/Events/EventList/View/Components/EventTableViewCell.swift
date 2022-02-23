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
  
  var event: Event? {
    didSet {
      if (event?.loadedImage == nil) {
        viewModel.getImage(imageUrl: event?.image ?? "")
      }
      eventTitle.text = event?.title ?? ""
    }
  }
  
  let viewModel = EventsTableViewCellViewModel()
  let disposeBag = DisposeBag()
  
  let activityIndicator: UIActivityIndicatorView = {
    let activity = UIActivityIndicatorView(style: .medium)
    activity.translatesAutoresizingMaskIntoConstraints = false
    return activity
  }()
  
  let eventImage: UIImageView = {
    let image = UIImageView()
    image.contentMode = .scaleAspectFill
    image.translatesAutoresizingMaskIntoConstraints = false
    image.clipsToBounds = true
//    image.layer.masksToBounds = false
    return image
  }()
  
  let eventTitle: UILabel = {
    let label = UILabel()
    label.font = UIFont(name: "AvenirNextCondensed-Medium", size: 15)
    label.numberOfLines = 0
    label.translatesAutoresizingMaskIntoConstraints = false
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
      eventImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
      eventImage.widthAnchor.constraint(equalToConstant: 70),
      eventImage.heightAnchor.constraint(equalToConstant: 70),
      eventImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
      
      eventTitle.leadingAnchor.constraint(equalTo: eventImage.trailingAnchor, constant: 10),
      eventTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
      eventTitle.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
      eventTitle.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
      
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
    viewModel.image
      .asObservable()
      .subscribe(onNext: {[weak self] image in
        self?.event?.setImage(image)
        self?.eventImage.maskCircle(anyImage: image)
        self?.activityIndicator.stopAnimating()
        self?.activityIndicator.removeFromSuperview()
      }).disposed(by: disposeBag)
    
//    eventImage.rx.observe(CGRect.self, #keyPath(UIView.bounds))
//      .observe(on: MainScheduler.instance)
//      .distinctUntilChanged()
//      .subscribe(onNext: {[weak self] bounds in
//        self?.eventImage.layer.cornerRadius = (bounds?.width ?? 0 / 2)
//      })
//      .disposed(by: disposeBag)
  }
  
  func setup(event: Event) {
    self.event = event
    
    setupView()
    activityIndicator.startAnimating()
  }
}
