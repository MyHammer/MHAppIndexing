//
//  MHCoreSpotlightObject.swift
//  Pods
//
//  Created by Frank Lienkamp on 12.02.16.
//
//

import UIKit
import CoreSpotlight

/// Protocol for objects required by **MHCoreSpotlightManager**. The properies correspond to the properties of **CSSearchableItem** and **CSSearchableItemAttributeSet**.
@available(iOS 9.0, *)
@objc public protocol MHCoreSpotlightObject {

    var mhDomainIdentifier: String { get }
    var mhUniqueIdentifier: String { get }
    var mhTitle: String { get }
    var mhContentDescription: String { get }
    var mhKeywords: Array<String> { get }
	var mhImageInfo: MHImageInfo? { get }

    optional var mhAttributeSet: CSSearchableItemAttributeSet { get }
    optional var mhExpirationDate:NSDate { get } // default is 30 days when not set
}