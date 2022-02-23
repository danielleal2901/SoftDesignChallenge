//
//  EventsView.swift
//  SoftDesignChallenge
//
//  Created by ACT on 22/02/22.
//

import Foundation
import UIKit
import RxSwift

class EventsView: UIView, ViewCodable {
  //MARK: Variables
  let viewModel: EventsViewModel
  let disposeBag = DisposeBag()
  weak var outputDelegate: EventsViewOutputDelegate?
  
  //MARK: Layout
  let searchBar: UISearchBar = {
    let searchBar = UISearchBar()
    searchBar.placeholder = "Search for event"
    searchBar.tintColor = .red
    searchBar.barStyle = .default
    searchBar.backgroundImage = UIImage()
    searchBar.translatesAutoresizingMaskIntoConstraints = false
    return searchBar
  }()
  
  let tableView: UITableView = {
    let tableView = UITableView()
    tableView.register(EventTableViewCell.self, forCellReuseIdentifier: EventTableViewCell.identifier)
    tableView.rowHeight = 60
    tableView.contentMode = .scaleAspectFill
    tableView.translatesAutoresizingMaskIntoConstraints = false
    return tableView
  }()
  
  lazy var loadingView: LoadingView = {
    let view = LoadingView()
    view.isHidden = true
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  lazy var errorView: SearchErrorView = {
    let view = SearchErrorView()
    view.isHidden = true
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  
  //MARK: Initializers
  init(viewModel: EventsViewModel = EventsViewModel()) {
    self.viewModel = viewModel
    
    super.init(frame: .zero)
    setupView()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  //MARK: Methods
  func addHierarchy() {
    addSubview(searchBar)
    addSubview(tableView)
    addSubview(errorView)
    addSubview(loadingView)
  }
  
  func addConstraints() {
    NSLayoutConstraint.activate([
      searchBar.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
      searchBar.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
      searchBar.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
      
      tableView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
      tableView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
      tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
      tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
      
      errorView.centerYAnchor.constraint(equalTo: centerYAnchor),
      errorView.centerXAnchor.constraint(equalTo: centerXAnchor),
      errorView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.8),

      
      loadingView.centerYAnchor.constraint(equalTo: centerYAnchor),
      loadingView.centerXAnchor.constraint(equalTo: centerXAnchor),
      loadingView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.8),
    ])
  }
  
  func bindUI() {
    bindTableView()
    bindSearchBar()
    bindLoading()
    bindErrors()
    
    viewModel.getEvents()
  }
  
  private func bindTableView() {
    viewModel.events.drive(tableView.rx.items(cellIdentifier: EventTableViewCell.identifier, cellType: EventTableViewCell.self))
    { (row, event, cell) in
      cell.setup(event: event)
    }.disposed(by: disposeBag)
    
    tableView.rx.modelSelected(Event.self).subscribe(onNext: {[weak self] event in
      self?.outputDelegate?.goEventDetailFlow(event: event)
      
    }).disposed(by: disposeBag)
    
    tableView.rx.itemSelected
      .subscribe(onNext: { [weak self] indexPath in
        self?.tableView.deselectRow(at: indexPath, animated: true)
      }).disposed(by: disposeBag)
  }
  
  private func bindSearchBar() {
    searchBar
      .rx
      .text
      .orEmpty
      .bind(to: self.viewModel.searchObserver)
      .disposed(by: disposeBag)
  }
  
  private func bindErrors() {
    viewModel.error
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
    viewModel.error.drive(errorView.rx.errorMessage)
      .disposed(by: disposeBag)
  }
  
  private func bindLoading() {
    viewModel.isLoading.asDriver().drive(tableView.rx.isHidden).disposed(by: disposeBag)
    viewModel.isLoading
        .map(!)
        .drive(loadingView.rx.isHidden)
        .disposed(by: disposeBag)
  }
}

