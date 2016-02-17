//
//  MHCoreSpotlightObject.swift
//  Pods
//
//  Created by Frank Lienkamp on 12.02.16.
//
//

import UIKit

@objc public protocol MHCoreSpotlightObject {

    var domainIdentifier: String { get }
    var uniqueIdentifier: String { get }
    var title: String { get }
    var contentDescription: String { get }
    var keywords: Array<String> { get }
	var imageInfo: MHImageInfo? { get }
	optional var imageURL: NSURL { get }
}