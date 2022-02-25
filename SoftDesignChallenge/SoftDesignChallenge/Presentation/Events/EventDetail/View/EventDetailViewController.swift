//
//  EventDetailViewController.swift
//  SoftDesignChallenge
//
//  Created by Daniel Leal on 22/02/22.
//

import Foundation
import UIKit

class EventDetailViewController: BaseViewController, ViewCodable, ImageRetriever {
  typealias ImageDescriptorType = EventDetailImage
  
  //MARK: Properties
  let event: Event
  let viewModel: EventDetailViewModel
  weak var coordinator: EventDetailViewCoordinatorDelegate?
  
  //MARK: Layout
  lazy var detailView: EventDetailView = {
    let view = EventDetailView(viewModel: viewModel)
    view.translatesAutoresizingMaskIntoConstraints = false
    view.outputDelegate = self
    return view
  }()
  
  //MARK: Initializers
  init(event: Event, viewModel: EventDetailViewModel? = nil){
    self.event = event
    self.viewModel = viewModel ?? EventDetailViewModel(event: event)
    
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
    view.addSubview(detailView)
  }
  
  func addConstraints() {
    NSLayoutConstraint.activate([
      detailView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      detailView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      detailView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      detailView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
    ])
  }
  
  func applyAdditionalConfiguration() {
    view.backgroundColor = .white
    
    setupNavigationBar()
  }
  
  @objc override func leftButtonAction(_ sender: Any?) {
    coordinator?.didFinishDetail()
  }

  private func setupNavigationBar() {
    setBarItem(image: image(.backArrow), size: CGSize(width: 24, height: 20), side: .left)
  }
  
}


