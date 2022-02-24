//
//  BaseViewController.swift
//  SoftDesignChallenge
//
//  Created by ACT on 22/02/22.
//

import Foundation
import UIKit

class BaseViewController: UIViewController {
  weak var coordinator: Coordinator?
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    print(String(describing: self))
  }
  
  func setLeftBarItem(image: UIImage) {
    let menuBtn = UIButton(type: .custom)
//    menuBtn.frame = CGRect(x: 0.0, y: 0.0, width: 23, height: 15)
    menuBtn.setImage(image, for: .normal)
    menuBtn.addTarget(self, action: #selector(backAction(_:)), for: UIControl.Event.touchUpInside)
    
    let menuBarItem = UIBarButtonItem(customView: menuBtn)
    let currWidth = menuBarItem.customView?.widthAnchor.constraint(equalToConstant: 24)
    currWidth?.isActive = true
    let currHeight = menuBarItem.customView?.heightAnchor.constraint(equalToConstant: 24)
    currHeight?.isActive = true
    self.navigationItem.leftBarButtonItem = menuBarItem
  }
  
  @objc func backAction(_ sender: Any){}

}
