//
//  EventsViewController.swift
//  SoftDesignChallenge
//
//  Created by ACT on 22/02/22.
//

import UIKit

class EventsViewController: BaseViewController, ViewCodable {
  //MARK: Layout
  lazy var eventsView: EventsView = {
    let view = EventsView()
    view.outputDelegate = self
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
    
  //MARK: Methods
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupView()
  }
  
  func addHierarchy() {
    view.addSubview(eventsView)
  }
  
  func addConstraints() {
    NSLayoutConstraint.activate([
      eventsView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      eventsView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      eventsView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      eventsView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
    ])
  }

  func applyAdditionalConfiguration() {
    view.backgroundColor = .white
    navigationItem.title = "Events Finder"
    navigationItem.hidesSearchBarWhenScrolling = false
    navigationController?.navigationBar.prefersLargeTitles = true
    definesPresentationContext = true
  }
  
}


