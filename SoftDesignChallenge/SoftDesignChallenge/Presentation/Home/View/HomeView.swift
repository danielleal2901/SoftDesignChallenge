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

  //MARK: Layout
  private lazy var tableView: UITableView = {
    let tableView = UITableView()
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
    viewModel.events.bind(to: tableView.rx.items(cellIdentifier: EventTableViewCell.identifier, cellType: EventTableViewCell.self))
    { (row, event, cell) in
      cell.setup(title: event.title, imageUrl: event.image)
    }.disposed(by: disposeBag)
    
    tableView.rx.modelSelected(EventTableViewCell.self).subscribe(onNext: { item in
        print("SelectedItem: \(item.title)")
    }).disposed(by: disposeBag)
    
    viewModel.getEvents()
  }
  
}
