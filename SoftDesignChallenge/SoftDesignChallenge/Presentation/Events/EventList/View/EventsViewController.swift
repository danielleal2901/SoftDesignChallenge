//
//  EventsViewController.swift
//  SoftDesignChallenge
//
//  Created by Daniel Leal on 22/02/22.
//

import Foundation
import UIKit
import RxSwift

fileprivate enum Constants {
  static let navigationTitle = "Eventos"
  static let searchBarPlaceholder = "Search for event"
}

class EventsViewController: BaseViewController, ViewCodable, ImageRetriever {
  typealias ImageDescriptorType = EventListImage
  
  //MARK: Properties
  weak var coordinator: EventsViewCoordinatorDelegate?
  let viewModel: EventsViewModel
  let disposeBag = DisposeBag()
  
  //MARK: Layout
  let searchBar: UISearchBar = {
    let searchBar = UISearchBar()
    searchBar.placeholder = Constants.searchBarPlaceholder
    searchBar.tintColor = .red
    searchBar.barStyle = .default
    searchBar.backgroundImage = UIImage()
    searchBar.translatesAutoresizingMaskIntoConstraints = false
    return searchBar
  }()
  
  let tableView: UITableView = {
    let tableView = UITableView()
    tableView.register(EventTableViewCell.self, forCellReuseIdentifier: EventTableViewCell.identifier)
    tableView.rowHeight = 80
    tableView.contentMode = .scaleAspectFill
    tableView.translatesAutoresizingMaskIntoConstraints = false
    return tableView
  }()
  
  let loadingView: LoadingView = {
    let view = LoadingView()
    view.isHidden = true
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  let errorView: SearchErrorView = {
    let view = SearchErrorView()
    view.isHidden = true
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
    view.addSubview(searchBar)
    view.addSubview(tableView)
    view.addSubview(errorView)
    view.addSubview(loadingView)
  }
  
  func addConstraints() {
    NSLayoutConstraint.activate([
      searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
      searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
      searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
      
      tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
      tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
      tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
      tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
      
      errorView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
      errorView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      errorView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
      
      loadingView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
      loadingView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      loadingView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
    ])
  }
  
  func bindUI() {
    bindView()
    bindErrors()
    viewModel.getEvents()
  }
  
  func applyAdditionalConfiguration() {
    view.backgroundColor = .white
    navigationItem.title = Constants.navigationTitle
  }
  
  private func bindView() {
    viewModel.events.drive(tableView.rx.items(cellIdentifier: EventTableViewCell.identifier, cellType: EventTableViewCell.self))
    { (row, event, cell) in
      cell.setup(event: event)
    }.disposed(by: disposeBag)
    
    tableView.rx.modelSelected(Event.self).subscribe(onNext: {[weak self] event in
      self?.coordinator?.showEventDetail(event: event)
    }).disposed(by: disposeBag)
    
    tableView.rx.itemSelected
      .subscribe(onNext: { [weak self] indexPath in
        self?.tableView.deselectRow(at: indexPath, animated: true)
      }).disposed(by: disposeBag)
    
    searchBar
      .rx
      .text
      .orEmpty
      .bind(to: viewModel.searchObserver)
      .disposed(by: disposeBag)
    
    viewModel.isLoading
      .asDriver()
      .drive(tableView.rx.isHidden)
      .disposed(by: disposeBag)
    
    viewModel.isLoading
      .map(!)
      .drive(loadingView.rx.isHidden)
      .disposed(by: disposeBag)
  }
  
  private func bindErrors() {
    viewModel.error
      .debug("Debug error", trimOutput: true)
      .map { $0 != nil }
      .drive(tableView.rx.isHidden)
      .disposed(by: disposeBag)
    viewModel.error
      .map { $0 != nil }
      .drive(loadingView.rx.isHidden)
      .disposed(by: disposeBag)
    viewModel.error
      .map { $0 == nil }
      .drive(errorView.rx.isHidden)
      .disposed(by: disposeBag)
    viewModel.error
      .drive(errorView.rx.errorMessage)
      .disposed(by: disposeBag)
  }
  
}

