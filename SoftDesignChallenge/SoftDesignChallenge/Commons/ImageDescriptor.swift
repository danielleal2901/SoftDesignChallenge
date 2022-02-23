//
//  ImageDescriptor.swift
//  SoftDesignChallenge
//
//  Created by ACT on 23/02/22.
//

import Foundation
import UIKit

public protocol ImageDescriptor: RawRepresentable where RawValue == String { }
public protocol ImageRetriever {
    associatedtype ImageDescriptorType: ImageDescriptor
    func image<ImageType: ImageDescriptor>(_ imageName: ImageType) -> UIImage
    func image(_ imageName: ImageDescriptorType) -> UIImage
}

public extension ImageRetriever where Self: BundleIdentifiable {
    func image<ImageType: ImageDescriptor>(_ imageName: ImageType) -> UIImage {
        return UIImage(named: imageName.rawValue, in: bundle, compatibleWith: nil)!
    }
    func image(_ imageName: ImageDescriptorType) -> UIImage {
        return UIImage(named: imageName.rawValue, in: bundle, compatibleWith: nil)!
    }
}

public extension ImageRetriever where Self: AnyObject {
    func image<ImageType: ImageDescriptor>(_ imageName: ImageType) -> UIImage {
        return UIImage(named: imageName.rawValue, in: Bundle(for: type(of: self)), compatibleWith: nil)!
    }
    func image(_ imageName: ImageDescriptorType) -> UIImage {
        return UIImage(named: imageName.rawValue, in: Bundle(for: type(of: self)), compatibleWith: nil)!
    }
}
