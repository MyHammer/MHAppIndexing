//
//  BeispielTestObjekt.swift
//  MHAppIndexing
//
//  Created by Andre Hess on 17.02.16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import UIKit
import MHAppIndexing

class BeispielTestObjekt: NSObject, MHUserActivityObject {
	
	var domainIdentifier: String
	var uniqueIdentifier: String
	var title: String
	var contentDescription: String
	var keywords: Array<String>
	var imageBundlePath: String
	var imageInfo: MHImageInfo?
	var userInfo:[String: NSSecureCoding]?
	var eligibleForSearch:Bool
	var eligibleForPublicIndexing:Bool
	var eligibleForHandoff:Bool
	var webpageURL:NSURL?
	var expirationDate:NSDate?
	
	override init() {
		self.domainIdentifier = ""
		self.uniqueIdentifier = ""
		self.title = ""
		self.contentDescription = ""
		self.keywords = []
		self.imageBundlePath = ""
		self.eligibleForSearch = false
		self.eligibleForPublicIndexing = false
		self.eligibleForHandoff = false
		super.init()
	}
}
