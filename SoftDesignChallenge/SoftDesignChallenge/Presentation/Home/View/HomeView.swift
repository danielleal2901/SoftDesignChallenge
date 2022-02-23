//
//  HomeView.swift
//  SoftDesignChallenge
//
//  Created by ACT on 22/02/22.
//

import Foundation
import UIKit
import RxSwift

class HomeView: UIView, ViewCodable {
  //MARK: Variables
  let viewModel = HomeViewModel()
  let disposeBag = DisposeBag()
  private var data: [Event] = [] {
    didSet {
      tableView.reloadData()
    }
  }
  
  //MARK: Layout
  private lazy var tableView: UITableView = {
    let tableView = UITableView()
    tableView.dataSource = self
    tableView.translatesAutoresizingMaskIntoConstraints = false
    tableView.register(EventTableViewCell.self, forCellReuseIdentifier: EventTableViewCell.identifier)
    tableView.rowHeight = UITableView.automaticDimension
    return tableView
  }()
  
  //MARK: Initializers
  init() {
    super.init(frame: .zero)
    setupView()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func addHierarchy() {
    addSubview(tableView)
  }
  
  func addConstraints() {
    NSLayoutConstraint.activate([
      tableView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
      tableView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
      tableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
      tableView.bottomAnchor.constraint(equalTo: bottomAnchor)
    ])
  }
  
  func applyAdditionalConfiguration() {
  }
  
  func bindUI() {
    viewModel.getEvents()
    
    viewModel.events.subscribe (onNext: {[weak self] events in
      self?.data = events
    }).disposed(by: disposeBag)
    
    viewModel.error.subscribe (onNext: {[weak self] error in
      print(error)
    }).disposed(by: disposeBag)
  }
  
}

extension HomeView: UITableViewDataSource {
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return data.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: EventTableViewCell.identifier, for: indexPath) as? EventTableViewCell
    else {
      return UITableViewCell()
    }
    cell.setup(title: data[indexPath.row].title, imageUrl: data[indexPath.row].image)
    return cell
  }
}
