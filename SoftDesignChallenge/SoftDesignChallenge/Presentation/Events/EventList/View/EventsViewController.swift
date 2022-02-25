//
//  EventsViewController.swift
//  SoftDesignChallenge
//
//  Created by Daniel Leal on 22/02/22.
//

import UIKit

fileprivate enum Constants {
  static let navigationTitle = "Eventos"
}

class EventsViewController: BaseViewController, ViewCodable, ImageRetriever {
  typealias ImageDescriptorType = EventListImage
  
  //MARK: Properties
  weak var coordinator: EventsViewCoordinatorDelegate?
  let viewModel: EventsViewModel

  //MARK: Layout
  lazy var eventsView: EventsView = {
    let view = EventsView(viewModel: viewModel)
    view.outputDelegate = self
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  //MARK: Initializers
  init(viewModel: EventsViewModel = EventsViewModel()) {
    self.viewModel = viewModel
    
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  //MARK: Methods
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  override func loadView() {
    super.loadView()
    
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
    navigationItem.title = Constants.navigationTitle
  }
  
}


