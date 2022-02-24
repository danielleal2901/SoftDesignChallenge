//
//  CheckInView.swift
//  SoftDesignChallenge
//
//  Created by ACT on 24/02/22.
//

import Foundation
import UIKit
import RxCocoa
import RxSwift

fileprivate enum Constants {
  static let checkInButton = "Fazer CheckIn"
  static let namePlaceholder = "Insira seu nome"
  static let emailPlaceholder = "Insira seu email"
}

class CheckInView: UIView, ViewCodable {
  //MARK: Properties
  let viewModel: EventDetailViewModel
  let disposeBag = DisposeBag()

  let verticalStack: UIStackView = {
    let stack = UIStackView()
    stack.axis = .vertical
    stack.distribution = .fillProportionally
    stack.spacing = 5
    stack.translatesAutoresizingMaskIntoConstraints = false
    return stack
  }()
  
  let nameTextfield: UITextField = {
    let textfield = UITextField()
    textfield.placeholder = Constants.namePlaceholder
    textfield.font = UIFont(name: "AvenirNextCondensed-Regular", size: 14)
    textfield.textColor = .black
    textfield.backgroundColor = .white
    textfield.layer.cornerRadius = 10
    textfield.clipsToBounds = true
    textfield.translatesAutoresizingMaskIntoConstraints = false
    return textfield
  }()
  
  let emailTextfield: UITextField = {
    let textfield = UITextField()
    textfield.placeholder = Constants.emailPlaceholder
    textfield.font = UIFont(name: "AvenirNextCondensed-Regular", size: 14)
    textfield.textColor = .black
    textfield.backgroundColor = .white
    textfield.layer.cornerRadius = 10
    textfield.clipsToBounds = true
    textfield.translatesAutoresizingMaskIntoConstraints = false
    return textfield
  }()
  
  lazy var checkInButton: UIButton = {
    let button = UIButton()
    button.translatesAutoresizingMaskIntoConstraints = false
    button.setTitle(Constants.checkInButton, for: .normal)
    button.setTitleColor(.black, for: .normal)
    button.titleLabel?.font = UIFont(name: "AvenirNextCondensed-DemiBold", size: 14)
    button.addTarget(self, action: #selector(tappedCheckIn(_:)), for: .touchUpInside)
    return button
  }()
  
  let responseLabel: UILabel = {
    let label = UILabel()
    label.isHidden = true
    label.textAlignment = .center
    label.font = UIFont(name: "AvenirNextCondensed-Regular", size: 12)
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  //MARK: Initializers
  init(viewModel: EventDetailViewModel){
    self.viewModel = viewModel
    
    super.init(frame: .zero)
    setupView()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  //MARK: Methods
  func addHierarchy() {
    addSubview(verticalStack)
    addSubview(checkInButton)
    
    verticalStack.addArrangedSubview(nameTextfield)
    verticalStack.addArrangedSubview(emailTextfield)
    verticalStack.addArrangedSubview(responseLabel)
  }
  
  func addConstraints() {
    NSLayoutConstraint.activate([
      verticalStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
      verticalStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
      verticalStack.topAnchor.constraint(equalTo: topAnchor, constant: 8),
      
      checkInButton.centerXAnchor.constraint(equalTo: centerXAnchor),
      checkInButton.topAnchor.constraint(equalTo: verticalStack.bottomAnchor, constant: 5),
      checkInButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
      
      nameTextfield.heightAnchor.constraint(equalToConstant: 40),
      emailTextfield.heightAnchor.constraint(equalToConstant: 40),
      responseLabel.heightAnchor.constraint(equalToConstant: 10)
    ])
  }
  
  func applyAdditionalConfiguration() {
    backgroundColor = .black.withAlphaComponent(0.05)
  }
  
  func bindUI() {
    viewModel.checkInResponse.filter({!$0.message.isEmpty})
      .drive(rx.response)
      .disposed(by: disposeBag)
  }
  
  @objc func tappedCheckIn(_ sender: Any){
    viewModel.sendCheckin(name: nameTextfield.text ?? "", email: emailTextfield.text ?? "")
  }
  
}

extension Reactive where Base: CheckInView {
  var response: Binder<CheckInResult> {
    return Binder(base) { base, value in
      base.responseLabel.text = value.message
      base.responseLabel.textColor = value.success ? .systemGreen : .systemRed
      base.responseLabel.isHidden = false
    }
  }
}
