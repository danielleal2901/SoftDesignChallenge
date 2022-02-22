//
//  ViewController.swift
//  SoftDesignChallenge
//
//  Created by ACT on 22/02/22.
//

import UIKit

class HomeViewController: BaseViewController, ViewCodable {

  private lazy var homeView: HomeView = {
    let view = HomeView()
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
    
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
  }
  
}
