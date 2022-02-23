//
//  EventDetailView.swift
//  SoftDesignChallenge
//
//  Created by ACT on 22/02/22.
//

import Foundation
import UIKit
import MapKit

class EventDetailView: UIView, ViewCodable {
  //MARK: Variables
  let event: Event
  
  //MARK: Layout
  private let scrollView : UIScrollView = {
    let scroll = UIScrollView()
    scroll.translatesAutoresizingMaskIntoConstraints = false
    return scroll
  }()
  
  private let contentView : UIView = {
    let view = UIView()
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  private let verticalStack: UIStackView = {
    let stack = UIStackView()
    stack.axis = .vertical
    stack.alignment = .center
    stack.distribution = .fillProportionally
    stack.translatesAutoresizingMaskIntoConstraints = false
    return stack
  }()
  
  private lazy var titleLabel: UILabel = {
    let label = UILabel()
    label.text = event.title
    label.translatesAutoresizingMaskIntoConstraints = false
    label.numberOfLines = 0
    return label
  }()
  
  private lazy var descriptionLabel: UILabel = {
    let label = UILabel()
    label.text = event.welcomeDescription
    label.translatesAutoresizingMaskIntoConstraints = false
    label.numberOfLines = 0
    return label
  }()
  
  private lazy var dateLabel: UILabel = {
    let label = UILabel()
    label.text = "29/01/2000"
    label.translatesAutoresizingMaskIntoConstraints = false
    label.numberOfLines = 0
    return label
  }()
  
  private let eventImage: UIImageView = {
    let image = UIImageView()
    image.contentMode = .scaleAspectFit
    image.backgroundColor = .red
    image.translatesAutoresizingMaskIntoConstraints = false
    return image
  }()
  
  private let mapView: MKMapView = {
    let map = MKMapView()
    map.backgroundColor = .yellow
    map.translatesAutoresizingMaskIntoConstraints = false
    return map
  }()
  
  //MARK: Initializers
  init(event: Event) {
    self.event = event
    
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
  }
  
  func addConstraints() {
    NSLayoutConstraint.activate([
      scrollView.topAnchor.constraint(equalTo: topAnchor),
      scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
      scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
      scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
      
      contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
      contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
      contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
      contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
      contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
      contentView.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor),
      
      eventImage.topAnchor.constraint(equalTo: contentView.topAnchor),
      eventImage.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
      eventImage.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.3),
      eventImage.heightAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.3),
      
      verticalStack.topAnchor.constraint(equalTo: eventImage.bottomAnchor, constant: 20),
      verticalStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30),
      verticalStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30),
      
      mapView.topAnchor.constraint(greaterThanOrEqualTo: descriptionLabel.bottomAnchor, constant: 50),
      mapView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
      mapView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
      mapView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
    ])
    
    let contentHeight = contentView.heightAnchor.constraint(greaterThanOrEqualTo: scrollView.heightAnchor)
    contentHeight.priority = .defaultLow
    contentHeight.isActive = true
  }
  
  func applyAdditionalConfiguration() {
    backgroundColor = .white
  }
  
  func bindUI() {
    
  }

}
