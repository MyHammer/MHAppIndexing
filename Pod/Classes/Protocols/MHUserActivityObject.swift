//
//  MHUserActivityObject.swift
//  Pods
//
//  Created by Frank Lienkamp on 12.02.16.
//
//

import UIKit

public protocol MHUserActivityObject: MHCoreSpotlightObject {
	var userInfo:[String: NSSecureCoding]? { get }
	var eligibleForSearch:Bool { get }
	var eligibleForPublicIndexing:Bool { get }
	var eligibleForHandoff:Bool { get }
	var webpageURL:NSURL? { get } // MUST be unique
}