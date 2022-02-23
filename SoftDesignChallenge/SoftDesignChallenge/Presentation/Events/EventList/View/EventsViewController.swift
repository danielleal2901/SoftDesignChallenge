//
//  EventsViewController.swift
//  SoftDesignChallenge
//
//  Created by ACT on 22/02/22.
//

import UIKit

class EventsViewController: BaseViewController, ViewCodable {
  //MARK: Layout
  private let searchController: UISearchController = {
    let searchController = UISearchController(searchResultsController: nil)
    searchController.searchBar.placeholder = "Search for event"
    return searchController
  }()

  private lazy var eventsView: EventsView = {
    let view = EventsView()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.outputDelegate = self
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
    view.backgroundColor = .cyan
    navigationItem.searchController = searchController
    navigationItem.title = "Events Finder"
    navigationItem.hidesSearchBarWhenScrolling = false
    navigationController?.navigationBar.prefersLargeTitles = true
  }
  
}


