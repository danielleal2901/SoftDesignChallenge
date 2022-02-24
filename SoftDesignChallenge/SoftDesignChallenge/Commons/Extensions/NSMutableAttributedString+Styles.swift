//
//  NSMutableAttributedString+Styles.swift
//  SoftDesignChallenge
//
//  Created by ACT on 23/02/22.
//

import Foundation
import UIKit

extension NSMutableAttributedString {
  func bold(
    fontSize: CGFloat = 14,
    boldFont: UIFont,
    value:String
  ) -> NSMutableAttributedString {
    let attributes:[NSAttributedString.Key : Any] = [
      .font : boldFont
    ]
    self.append(NSAttributedString(string: value, attributes:attributes))
    return self
  }
  
  func normal(
    fontSize: CGFloat = 14,
    normalFont: UIFont ,
    value:String
  ) -> NSMutableAttributedString {
    
    let attributes:[NSAttributedString.Key : Any] = [
      .font : normalFont,
    ]
    
    self.append(NSAttributedString(string: value, attributes:attributes))
    return self
  }
  
}
