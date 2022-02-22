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
  let viewModel: HomeViewModel
  let disposeBag = DisposeBag()
  private var data: [Event] = [] {
    didSet {
      tableView.reloadData()
    }
  }
  
  //MARK: Layout
  private lazy var titleLabel: UILabel = {
    let label = UILabel()
    label.text = "Eventos"
    label.font = UIFont(name: "SF Pro", size: 25)
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  private lazy var tableView: UITableView = {
    let tableView = UITableView()
    tableView.dataSource = self
    tableView.translatesAutoresizingMaskIntoConstraints = false
    return tableView
  }()
  
  //MARK: Initializers
  init(viewModel: HomeViewModel = HomeViewModelDefault()) {
    self.viewModel = viewModel
    
    super.init(frame: .zero)
    setupView()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func addHierarchy() {
    addSubview(titleLabel)
    addSubview(tableView)
  }
  
  func addConstraints() {
    NSLayoutConstraint.activate([
        titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
        titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
    ])
    NSLayoutConstraint.activate([
        tableView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
        tableView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
        tableView.topAnchor.constraint(equalTo: titleLabel.topAnchor, constant: 20),
        tableView.bottomAnchor.constraint(equalTo: bottomAnchor)
    ])
  }
  
  func applyAdditionalConfiguration() {
  }
  
  func bindUI() {
    viewModel.getEvents()

    viewModel.events.subscribe {[weak self] events in
      self?.data = events
    }.disposed(by: disposeBag)
    
    viewModel.error.subscribe {[weak self] error in
      print(error)
    }.disposed(by: disposeBag)
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
    return UITableViewCell()
  }
  
  
}
