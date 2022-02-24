//
//  BaseViewController.swift
//  SoftDesignChallenge
//
//  Created by Daniel Leal on 22/02/22.
//

import Foundation
import UIKit

class BaseViewController: UIViewController {
  enum BarButtonSide {
    case left
    case right
  }
  
  weak var coordinator: Coordinator?
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    print(String(describing: self))
  }
  
  func setBarItem(image: UIImage, size: CGSize, side: BarButtonSide) {
    let menuBtn = UIButton(type: .custom)
    menuBtn.setImage(image, for: .normal)
    
    let menuBarItem = UIBarButtonItem(customView: menuBtn)
    let currWidth = menuBarItem.customView?.widthAnchor.constraint(equalToConstant: size.width)
    currWidth?.isActive = true
    let currHeight = menuBarItem.customView?.heightAnchor.constraint(equalToConstant: size.height)
    currHeight?.isActive = true
    
    if (side == .left) {
      self.navigationItem.leftBarButtonItem = menuBarItem
      menuBtn.addTarget(self, action: #selector(leftButtonAction(_:)), for: UIControl.Event.touchUpInside)
    }
    else {
      self.navigationItem.rightBarButtonItem = menuBarItem
      menuBtn.addTarget(self, action: #selector(rightButtonAction(_:)), for: UIControl.Event.touchUpInside)
    }
  }
  
  
  @objc func leftButtonAction(_ sender: Any){}
  @objc func rightButtonAction(_ sender: Any){}
  
}
