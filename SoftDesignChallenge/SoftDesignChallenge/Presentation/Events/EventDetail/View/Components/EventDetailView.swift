//
//  EventDetailView.swift
//  SoftDesignChallenge
//
//  Created by ACT on 22/02/22.
//

import Foundation
import UIKit
import CoreLocation

class EventDetailView: UIView, ViewCodable {
  //MARK: Properties
  let event: Event
  let viewModel: EventDetailViewModel
  weak var outputDelegate: EventDetailViewOutputDelegate?
  var mapNormalTopConstraint: NSLayoutConstraint?
  var mapNormalHeightConstraint: NSLayoutConstraint?
  var mapFullscreenTopConstraint: NSLayoutConstraint?

  //MARK: Layout
  let scrollView : UIScrollView = {
    let scroll = UIScrollView()
    scroll.translatesAutoresizingMaskIntoConstraints = false
    return scroll
  }()
  
  let contentView : UIView = {
    let view = UIView()
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  let verticalStack: UIStackView = {
    let stack = UIStackView()
    stack.axis = .vertical
    stack.alignment = .center
    stack.distribution = .fillProportionally
    stack.spacing = 10
    stack.translatesAutoresizingMaskIntoConstraints = false
    return stack
  }()
  
  lazy var titleLabel: UILabel = {
    let label = UILabel()
    label.text = event.title
    label.textAlignment = .center
    label.numberOfLines = 0
    label.font = UIFont(name: "AvenirNextCondensed-DemiBold", size: 16)
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  lazy var descriptionLabel: UILabel = {
    let label = UILabel()
    label.text = event.welcomeDescription
    label.textAlignment = .justified
    label.numberOfLines = 0
    label.font = UIFont(name: "AvenirNextCondensed-Regular", size: 14)
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  lazy var dateLabel: UILabel = {
    let label = UILabel()
    let attributedString = NSMutableAttributedString()
            .bold(
              boldFont: UIFont(name: "AvenirNextCondensed-DemiBold", size: 13) ??
              UIFont.boldSystemFont(ofSize: 13),
              value: "Data: "
            )
            .normal(
              normalFont: UIFont(name: "AvenirNextCondensed-Medium", size: 12) ??
              UIFont.systemFont(ofSize: 12),
              value: event.getFormattedDate()
            )
    label.attributedText = attributedString
    label.textAlignment = .left
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  lazy var eventImage: UIImageView = {
    let image = UIImageView()
    image.image = event.loadedImage
    image.contentMode = .scaleAspectFill
    image.layer.cornerRadius = 10.0
    image.layer.masksToBounds = true
    image.clipsToBounds = true
    image.translatesAutoresizingMaskIntoConstraints = false
    return image
  }()
  
  lazy var mapView: EventMapView = {
    let map = EventMapView(event: event)
    map.outputDelegate = self
    map.translatesAutoresizingMaskIntoConstraints = false
    return map
  }()
    
  //MARK: Initializers
  init(event: Event, viewModel: EventDetailViewModel = EventDetailViewModel()) {
    self.event = event
    self.viewModel = viewModel
    
    super.init(frame: .zero)
    setupView()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  //MARK: Methods
  func addHierarchy() {
    addSubview(scrollView)
    scrollView.addSubview(contentView)
    contentView.addSubview(eventImage)
    contentView.addSubview(verticalStack)
    contentView.addSubview(mapView)
    
    verticalStack.addArrangedSubview(titleLabel)
    verticalStack.addArrangedSubview(descriptionLabel)
    verticalStack.addArrangedSubview(dateLabel)
  }
  
  func addConstraints() {
    var constraints = [NSLayoutConstraint]()
    constraints.append(contentsOf: scrollViewConstraints())
    constraints.append(contentsOf: contentViewConstraints())
    constraints.append(contentsOf: eventImageConstraints())
    constraints.append(contentsOf: verticalStackConstraints())
    constraints.append(contentsOf: mapConstraints())
    
    NSLayoutConstraint.activate(constraints)
  }
  
  func applyAdditionalConfiguration() {
    backgroundColor = .white
  }
  

}
