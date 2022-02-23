//
//  EventDetailViewController.swift
//  SoftDesignChallenge
//
//  Created by ACT on 22/02/22.
//

import Foundation
import UIKit

class EventDetailViewController: BaseViewController, ViewCodable {
  //MARK: Variables
  let event: Event
  
  //MARK: Layout
  private lazy var detailView: EventDetailView = {
    let view = EventDetailView(event: event)
    view.translatesAutoresizingMaskIntoConstraints = false
    view.outputDelegate = self
    return view
  }()
  
  //MARK: Initializers
  init(event: Event){
    self.event = event
    
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  //MARK: Methods
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupView()
  }
  
  func addHierarchy() {
    view.addSubview(detailView)
  }
  
  func addConstraints() {
    NSLayoutConstraint.activate([
      detailView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      detailView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      detailView.topAnchor.constraint(equalTo: view.topAnchor),
      detailView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
    ])
  }
  
}


