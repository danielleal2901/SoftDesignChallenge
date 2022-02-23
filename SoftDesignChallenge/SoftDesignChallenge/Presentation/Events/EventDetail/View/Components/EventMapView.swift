//
//  EventMapView.swift
//  SoftDesignChallenge
//
//  Created by ACT on 23/02/22.
//

import Foundation
import MapKit
import RxSwift
import CoreLocation

class EventMapView: UIView, ViewCodable, ImageRetriever {
  typealias ImageDescriptorType = EventDetailImage

  //MARK: Variables
  let event: Event
  private var mapHeightConstraint: NSLayoutConstraint?

  private var isMapExpanded: Bool = false {
    didSet {
      closeMap.isHidden = !isMapExpanded
    }
  }
  weak var outputDelegate: EventMapViewOutputDelegate?

  //MARK: Layout
  lazy var mapView: MKMapView = {
    let map = MKMapView()
    map.translatesAutoresizingMaskIntoConstraints = false
    map.addGestureRecognizer(gesture)
    return map
  }()
  
  lazy var closeMap: UIButton = {
    let button = UIButton()
    button.setImage(image(.close), for: .normal)
    button.translatesAutoresizingMaskIntoConstraints = false
    button.isHidden = true
    button.addTarget(self, action: #selector(closeMapFullscreen(_:)), for: .touchUpInside)
    return button
  }()
  
  lazy var gesture: UITapGestureRecognizer = {
    let gesture = UITapGestureRecognizer()
    gesture.addTarget(self, action: #selector(touchedMap(_:)))
    return gesture
  }()
  
  //MARK: Initializers
  init(event: Event){
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
    
    DispatchQueue.main.async {
      self.updateLocationOnMap(to: CLLocation(latitude: self.event.latitude, longitude: self.event.longitude), with: self.event.title)
    }
  }
  
  func addHierarchy() {
    addSubview(mapView)
    addSubview(closeMap)
  }
  
  func addConstraints() {
    NSLayoutConstraint.activate([
      mapView.topAnchor.constraint(equalTo: topAnchor),
      mapView.bottomAnchor.constraint(equalTo: bottomAnchor),
      mapView.leadingAnchor.constraint(equalTo: leadingAnchor),
      mapView.trailingAnchor.constraint(equalTo: trailingAnchor),
      
      closeMap.topAnchor.constraint(equalTo: topAnchor, constant: 30),
      closeMap.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
      closeMap.heightAnchor.constraint(equalToConstant: 40),
      closeMap.widthAnchor.constraint(equalToConstant: 40)
    ])
    
  }
  
  @objc func touchedMap(_ sender: Any){
    if (!isMapExpanded) {
      showMapFullscreen()
    }
  }
  
  @objc func closeMapFullscreen(_ sender: Any) {
    if (isMapExpanded){
      removeMapFullscreen()
    }
  }
  
  private func updateLocationOnMap(to location: CLLocation, with title: String?) {
      let point = MKPointAnnotation()
      point.title = title
      point.coordinate = location.coordinate
      self.mapView.addAnnotation(point)

      let viewRegion = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 200, longitudinalMeters: 200)
      self.mapView.setRegion(viewRegion, animated: true)
  }
  
  private func showMapFullscreen() {
    isMapExpanded = true
    outputDelegate?.showMapInFullscreen()
  }
  
  private func removeMapFullscreen() {
    isMapExpanded = false
    outputDelegate?.removeMapFullscreen()
  }

}
