//
//  MHUserActivityObject.swift
//  Pods
//
//  Created by Frank Lienkamp on 12.02.16.
//
//

import UIKit

public protocol MHUserActivityObject: MHCoreSpotlightObject {
	var mhUserInfo:[String: NSSecureCoding]? { get }
	var mhEligibleForSearch:Bool { get }
	var mhEligibleForPublicIndexing:Bool { get }
	var mhEligibleForHandoff:Bool { get }
	var mhWebpageURL:NSURL? { get } // MUST be unique
}