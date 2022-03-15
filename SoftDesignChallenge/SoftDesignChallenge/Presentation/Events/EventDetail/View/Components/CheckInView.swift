//
//  CheckInView.swift
//  SoftDesignChallenge
//
//  Created by Daniel Leal on 24/02/22.
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

class CheckInView: UIView, ViewCodable, ImageRetriever {
  typealias ImageDescriptorType = EventDetailImage
  
  //MARK: Properties
  weak var outputDelegate: CheckInOutputDelegate?
  let disposeBag = DisposeBag()
  
  //MARK: Layout
  let backgroundView: UIView = {
    let view = UIView()
    view.backgroundColor = .black.withAlphaComponent(0.4)
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  let containerView: UIView = {
    let view = UIView()
    view.backgroundColor = .white
    view.layer.cornerRadius = 15.0
    view.clipsToBounds = true
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()

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
    textfield.backgroundColor = .black.withAlphaComponent(0.1)
    textfield.layer.cornerRadius = 10
    textfield.clipsToBounds = true
    textfield.leftView = UIView(frame: .init(origin: .zero, size: CGSize(width: 5, height: 0)))
    textfield.leftViewMode = .always
    textfield.translatesAutoresizingMaskIntoConstraints = false
    return textfield
  }()
  
  let emailTextfield: UITextField = {
    let textfield = UITextField()
    textfield.placeholder = Constants.emailPlaceholder
    textfield.font = UIFont(name: "AvenirNextCondensed-Regular", size: 14)
    textfield.textColor = .black
    textfield.backgroundColor = .black.withAlphaComponent(0.1)
    textfield.layer.cornerRadius = 10
    textfield.clipsToBounds = true
    textfield.leftView = UIView(frame: .init(origin: .zero, size: CGSize(width: 5, height: 0)))
    textfield.leftViewMode = .always
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
  
  lazy var closeButton: UIButton = {
    let button = UIButton()
    button.setImage(image(.close), for: .normal)
    button.translatesAutoresizingMaskIntoConstraints = false
    button.addTarget(self, action: #selector(tappedClose(_:)), for: .touchUpInside)
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
  init(){
    super.init(frame: .zero)
    setupView()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  //MARK: Methods
  func addHierarchy() {
    addSubview(backgroundView)
    
    backgroundView.addSubview(containerView)
    containerView.addSubview(closeButton)
    containerView.addSubview(verticalStack)
    containerView.addSubview(checkInButton)
    
    verticalStack.addArrangedSubview(nameTextfield)
    verticalStack.addArrangedSubview(emailTextfield)
    verticalStack.addArrangedSubview(responseLabel)
  }
  
  func addConstraints() {
    NSLayoutConstraint.activate([
      backgroundView.topAnchor.constraint(equalTo: topAnchor),
      backgroundView.bottomAnchor.constraint(equalTo: bottomAnchor),
      backgroundView.leadingAnchor.constraint(equalTo: leadingAnchor),
      backgroundView.trailingAnchor.constraint(equalTo: trailingAnchor),
      
      containerView.centerYAnchor.constraint(equalTo: centerYAnchor),
      containerView.centerXAnchor.constraint(equalTo: centerXAnchor),
      containerView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.6),
      
      closeButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10),
      closeButton.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 10),
      closeButton.heightAnchor.constraint(equalToConstant: 30),
      closeButton.widthAnchor.constraint(equalToConstant: 30),
      
      verticalStack.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10),
      verticalStack.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10),
      verticalStack.topAnchor.constraint(equalTo: closeButton.bottomAnchor, constant: 15),
      
      checkInButton.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
      checkInButton.topAnchor.constraint(equalTo: verticalStack.bottomAnchor, constant: 10),
      checkInButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -10),
      
      nameTextfield.heightAnchor.constraint(equalToConstant: 40),
      emailTextfield.heightAnchor.constraint(equalToConstant: 40),
      responseLabel.heightAnchor.constraint(equalToConstant: 10)
    ])
  }
  
  func applyAdditionalConfiguration() {
    backgroundColor = .black.withAlphaComponent(0.05)
    
    let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
    tap.cancelsTouchesInView = false
    addGestureRecognizer(tap)
  }
  
  @objc func dismissKeyboard() {
    endEditing(true)
  }
  @objc func tappedCheckIn(_ sender: Any){
    outputDelegate?.sendCheckIn(name: nameTextfield.text ?? "", email: emailTextfield.text ?? "")
  }
  
  @objc func tappedClose(_ sender: Any?){
    isHidden = true
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
