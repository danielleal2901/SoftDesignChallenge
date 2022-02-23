//
//  EventDetailView.swift
//  SoftDesignChallenge
//
//  Created by ACT on 22/02/22.
//

import Foundation
import UIKit
import MapKit
import CoreLocation

class EventDetailView: UIView, ViewCodable {
  //MARK: Variables
  let event: Event
  
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
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  lazy var descriptionLabel: UILabel = {
    let label = UILabel()
    label.text = event.welcomeDescription
    label.textAlignment = .justified
    label.numberOfLines = 0
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  lazy var dateLabel: UILabel = {
    let label = UILabel()
    label.text = "29/01/2000"
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  let eventImage: UIImageView = {
    let image = UIImageView()
    image.contentMode = .scaleAspectFit
    image.backgroundColor = .red
    image.translatesAutoresizingMaskIntoConstraints = false
    return image
  }()
  
  lazy var mapView: MKMapView = {
    let map = MKMapView()
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
  override func didMoveToSuperview() {
    super.didMoveToSuperview()
    
    DispatchQueue.global(qos: .userInitiated).async {
      self.updateLocationOnMap(to: CLLocation(latitude: self.event.latitude, longitude: self.event.longitude), with: self.event.title)
    }
  }
  
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
  
  private func updateLocationOnMap(to location: CLLocation, with title: String?) {
      let point = MKPointAnnotation()
      point.title = title
      point.coordinate = location.coordinate
      self.mapView.addAnnotation(point)

      let viewRegion = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 200, longitudinalMeters: 200)
      self.mapView.setRegion(viewRegion, animated: true)
  }

}
