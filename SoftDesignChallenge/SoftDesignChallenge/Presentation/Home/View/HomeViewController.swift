//
//  ViewController.swift
//  SoftDesignChallenge
//
//  Created by ACT on 22/02/22.
//

import UIKit

class HomeViewController: BaseViewController, ViewCodable {
  //MARK: Layout
  private let searchController: UISearchController = {
    let searchController = UISearchController(searchResultsController: nil)
    searchController.searchBar.placeholder = "Search for event"
    return searchController
  }()

  private lazy var homeView: HomeView = {
    let view = HomeView()
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
    
  //MARK: Methods
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupView()
  }
  
  func addHierarchy() {
    view.addSubview(homeView)
  }
  
  func addConstraints() {
    NSLayoutConstraint.activate([
        homeView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
        homeView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        homeView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
        homeView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
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
