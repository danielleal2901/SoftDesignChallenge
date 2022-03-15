//
//  EventDetailViewController.swift
//  SoftDesignChallenge
//
//  Created by Daniel Leal on 22/02/22.
//

import Foundation
import UIKit
import RxSwift

class EventDetailViewController: BaseViewController, ViewCodable, ImageRetriever {
  typealias ImageDescriptorType = EventDetailImage
  
  //MARK: Properties
  let disposeBag = DisposeBag()
  let viewModel: EventDetailViewModel
  weak var coordinator: EventDetailViewCoordinatorDelegate?
  
  //MARK: Layout
  lazy var detailView: EventDetailView = {
    let view = EventDetailView(state:
      EventDetailState(
        title: viewModel.title,
        image: viewModel.image,
        description: viewModel.description,
        date: viewModel.date,
        longitude: viewModel.longitude,
        latitude: viewModel.latitude
      ))
    view.translatesAutoresizingMaskIntoConstraints = false
    view.outputDelegate = self
    return view
  }()
  
  lazy var checkInView: CheckInView = {
    let view = CheckInView(viewModel: viewModel)
    view.translatesAutoresizingMaskIntoConstraints = false
    view.isHidden = true
    return view
  }()
  
  //MARK: Initializers
  init(viewModel: EventDetailViewModel){
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
    view.addSubview(detailView)
    view.addSubview(checkInView)
  }
  
  func addConstraints() {
    NSLayoutConstraint.activate([
      detailView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      detailView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      detailView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      detailView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
      
      checkInView.topAnchor.constraint(equalTo: view.topAnchor),
      checkInView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
      checkInView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      checkInView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
    ])
  }
  
  func applyAdditionalConfiguration() {
    view.backgroundColor = .white
    
    setupNavigationBar()
  }
  
  func bindUI() {
    detailView.checkInView.outputDelegate = self
    viewModel.checkInResponse
      .drive(detailView.checkInView.rx.response)
      .disposed(by: disposeBag)
  }

  @objc override func leftButtonAction(_ sender: Any?) {
    coordinator?.didFinishDetail()
  }
  
  @objc override func rightButtonAction(_ sender: Any?) {
    checkInView.isHidden = false
  }

  private func setupNavigationBar() {
    setBarItem(image: image(.backArrow), size: CGSize(width: 24, height: 20), side: .left)
    setBarItem(image: image(.add), size: CGSize(width: 25, height: 25), side: .right)
  }
  
}

extension EventDetailViewController: CheckInOutputDelegate {
  func sendCheckIn(name: String, email: String) {
    viewModel.sendCheckin(name: name, email: email)
  }
}


