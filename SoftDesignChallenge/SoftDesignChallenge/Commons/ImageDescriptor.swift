//
//  ImageDescriptor.swift
//  SoftDesignChallenge
//
//  Created by Daniel Leal on 23/02/22.
//

import Foundation
import UIKit

public protocol ImageDescriptor: RawRepresentable where RawValue == String { }
public protocol ImageRetriever {
    associatedtype ImageDescriptorType: ImageDescriptor
    func image(_ imageName: ImageDescriptorType) -> UIImage
}

public extension ImageRetriever where Self: AnyObject {
    func image(_ imageName: ImageDescriptorType) -> UIImage {
        return UIImage(named: imageName.rawValue, in: Bundle(for: type(of: self)), compatibleWith: nil)!
    }
}
