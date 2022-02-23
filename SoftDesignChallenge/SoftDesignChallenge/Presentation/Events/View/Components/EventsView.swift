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
  let viewModel = EventsViewModel()
  let disposeBag = DisposeBag()
  weak var outputDelegate: EventsViewOutputDelegate?

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
    bindTableView()
    
    viewModel.error.subscribe(onNext: {[weak self] error in
      print(error)
    })
    
    viewModel.getEvents()
  }
  
  private func bindTableView() {
    viewModel.events.bind(to: tableView.rx.items(cellIdentifier: EventTableViewCell.identifier, cellType: EventTableViewCell.self))
    { (row, event, cell) in
      cell.setup(title: event.title, imageUrl: event.image)
    }.disposed(by: disposeBag)
    
    tableView.rx.modelSelected(Event.self).subscribe(onNext: { event in
        print("SelectedItem: \(event.title)")
    }).disposed(by: disposeBag)
  }
  
}
