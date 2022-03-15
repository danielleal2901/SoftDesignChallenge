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
  
  var mapNormalTopConstraint: NSLayoutConstraint?
  var mapNormalHeightConstraint: NSLayoutConstraint?
  var mapFullscreenTopConstraint: NSLayoutConstraint?
  
  //MARK: Layout
  let scrollView : UIScrollView = {
    let scroll = UIScrollView()
    scroll.translatesAutoresizingMaskIntoConstraints = false
    return scroll
  }()
  
  let contentView : UIView = {
    let view = UIView()
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  let verticalStack: UIStackView = {
    let stack = UIStackView()
    stack.axis = .vertical
    stack.alignment = .center
    stack.distribution = .fillProportionally
    stack.spacing = 10
    stack.translatesAutoresizingMaskIntoConstraints = false
    return stack
  }()
  
  lazy var titleLabel: UILabel = {
    let label = UILabel()
    label.text = viewModel.title
    label.textAlignment = .center
    label.numberOfLines = 0
    label.font = UIFont(name: "AvenirNextCondensed-DemiBold", size: 16)
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  lazy var descriptionLabel: UILabel = {
    let label = UILabel()
    label.text = viewModel.description
    label.textAlignment = .justified
    label.numberOfLines = 0
    label.font = UIFont(name: "AvenirNextCondensed-Regular", size: 14)
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  lazy var dateLabel: UILabel = {
    let label = UILabel()
    label.attributedText = viewModel.date
    label.textAlignment = .left
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  lazy var eventImage: UIImageView = {
    let image = UIImageView()
    image.image = viewModel.image
    image.contentMode = .scaleAspectFill
    image.layer.cornerRadius = 10.0
    image.layer.masksToBounds = true
    image.clipsToBounds = true
    image.translatesAutoresizingMaskIntoConstraints = false
    return image
  }()
  
  lazy var mapView: EventMapView = {
    let map =
    EventMapView(state:
                  EventMapState(
                    longitude: viewModel.longitude,
                    latitude: viewModel.latitude,
                    title: viewModel.title
                  )
    )
    map.outputDelegate = self
    map.translatesAutoresizingMaskIntoConstraints = false
    return map
  }()
  
  lazy var checkInView: CheckInView = {
    let view = CheckInView()
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
  
  //MARK: Methods
  func addHierarchy() {
    view.addSubview(scrollView)
    scrollView.addSubview(contentView)
    contentView.addSubview(eventImage)
    contentView.addSubview(verticalStack)
    contentView.addSubview(mapView)
    contentView.addSubview(checkInView)
    
    verticalStack.addArrangedSubview(titleLabel)
    verticalStack.addArrangedSubview(descriptionLabel)
    verticalStack.addArrangedSubview(dateLabel)
  }
  
  func addConstraints() {
    var constraints = [NSLayoutConstraint]()
    constraints.append(contentsOf: scrollViewConstraints())
    constraints.append(contentsOf: contentViewConstraints())
    constraints.append(contentsOf: eventImageConstraints())
    constraints.append(contentsOf: verticalStackConstraints())
    constraints.append(contentsOf: mapConstraints())
    constraints.append(contentsOf: checkInConstraints())
    
    NSLayoutConstraint.activate(constraints)
  }
  
  func applyAdditionalConfiguration() {
    view.backgroundColor = .white
    
    setupNavigationBar()
  }
  
  func bindUI() {
    checkInView.outputDelegate = self
    viewModel.checkInResponse
      .drive(checkInView.rx.response)
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

extension EventDetailViewController: EventMapViewOutputDelegate {
  func showMapInFullscreen() {
    mapNormalHeightConstraint?.isActive = false
    mapNormalTopConstraint?.isActive = false
    mapFullscreenTopConstraint?.isActive = true
    
    navigationController?.setNavigationBarHidden(true, animated: false)
    UIView.animate(withDuration: 0.3) {
      self.view.layoutIfNeeded()
    }
  }
  
  func removeMapFullscreen() {
    mapFullscreenTopConstraint?.isActive = false
    mapNormalTopConstraint?.isActive = true
    mapNormalHeightConstraint?.isActive = true

    navigationController?.setNavigationBarHidden(false, animated: false)
    UIView.animate(withDuration: 0.3) {
      self.view.layoutIfNeeded()
    }
  }
}
