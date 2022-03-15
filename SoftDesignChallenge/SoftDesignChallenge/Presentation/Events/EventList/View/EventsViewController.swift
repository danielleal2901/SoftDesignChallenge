//
//  EventsViewController.swift
//  SoftDesignChallenge
//
//  Created by Daniel Leal on 22/02/22.
//

import UIKit
import RxSwift

fileprivate enum Constants {
  static let navigationTitle = "Eventos"
}

class EventsViewController: BaseViewController, ViewCodable, ImageRetriever {
  typealias ImageDescriptorType = EventListImage
  
  //MARK: Properties
  weak var coordinator: EventsViewCoordinatorDelegate?
  let viewModel: EventsViewModel
  let disposeBag = DisposeBag()

  //MARK: Layout
  lazy var eventsView: EventsView = {
    let view = EventsView()
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
  
  func bindUI() {
    bindView()
    bindErrors()
    
    viewModel.getEvents()
  }
  
  private func bindView() {
    viewModel.events.drive(eventsView.tableView.rx.items(cellIdentifier: EventTableViewCell.identifier, cellType: EventTableViewCell.self))
    { (row, event, cell) in
      cell.setup(event: event)
    }.disposed(by: disposeBag)
    
    eventsView.searchBar
      .rx
      .text
      .orEmpty
      .bind(to: viewModel.searchObserver)
      .disposed(by: disposeBag)
    
    viewModel.isLoading
      .asDriver()
      .drive(eventsView.tableView.rx.isHidden)
      .disposed(by: disposeBag)
    
    viewModel.isLoading
        .map(!)
        .drive(eventsView.loadingView.rx.isHidden)
        .disposed(by: disposeBag)
  }
  
  private func bindErrors() {
    viewModel.error
        .map { $0 != nil }
        .drive(eventsView.tableView.rx.isHidden)
        .disposed(by: disposeBag)
    viewModel.error
        .map { $0 != nil }
        .drive(eventsView.loadingView.rx.isHidden)
        .disposed(by: disposeBag)
    viewModel.error
        .map { $0 == nil }
        .drive(eventsView.errorView.rx.isHidden)
        .disposed(by: disposeBag)
    viewModel.error
      .drive(eventsView.errorView.rx.errorMessage)
      .disposed(by: disposeBag)
  }
}


