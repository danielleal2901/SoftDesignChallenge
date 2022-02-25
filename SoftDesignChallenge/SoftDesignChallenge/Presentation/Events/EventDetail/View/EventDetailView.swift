//
//  EventDetailView.swift
//  SoftDesignChallenge
//
//  Created by Daniel Leal on 22/02/22.
//

import Foundation
import UIKit
import CoreLocation

class EventDetailView: UIView, ViewCodable {
  //MARK: Properties
  let viewModel: EventDetailViewModel
  weak var outputDelegate: EventDetailViewOutputDelegate?
  var mapNormalTopConstraint: NSLayoutConstraint?
  var mapNormalHeightConstraint: NSLayoutConstraint?
  var mapFullscreenTopConstraint: NSLayoutConstraint?
  var mapFullscreenBottomConstraint: NSLayoutConstraint?

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
    label.text = viewModel.title
    label.textAlignment = .center
    label.numberOfLines = 0
    label.font = UIFont(name: "AvenirNextCondensed-DemiBold", size: 16)
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  lazy var descriptionLabel: UILabel = {
    let label = UILabel()
    label.text = viewModel.description
    label.textAlignment = .justified
    label.numberOfLines = 0
    label.font = UIFont(name: "AvenirNextCondensed-Regular", size: 14)
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  lazy var dateLabel: UILabel = {
    let label = UILabel()
    label.attributedText = viewModel.date
    label.textAlignment = .left
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  lazy var eventImage: UIImageView = {
    let image = UIImageView()
    image.image = viewModel.image
    image.contentMode = .scaleAspectFill
    image.layer.cornerRadius = 10.0
    image.layer.masksToBounds = true
    image.clipsToBounds = true
    image.translatesAutoresizingMaskIntoConstraints = false
    return image
  }()
  
  lazy var mapView: EventMapView = {
    let map = EventMapView(event: viewModel.event)
    map.outputDelegate = self
    map.translatesAutoresizingMaskIntoConstraints = false
    return map
  }()
  
  lazy var checkInView: CheckInView = {
    let view = CheckInView(viewModel: viewModel)
    view.layer.cornerRadius = 10
    view.clipsToBounds = true
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
    
  //MARK: Initializers
  init(viewModel: EventDetailViewModel) {
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
    contentView.addSubview(checkInView)
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
    constraints.append(contentsOf: checkInConstraints())
    
    NSLayoutConstraint.activate(constraints)
  }
  
  func applyAdditionalConfiguration() {
    backgroundColor = .white
  }
}
