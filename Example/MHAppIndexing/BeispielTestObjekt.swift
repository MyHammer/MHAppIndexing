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
	
	var mhDomainIdentifier: String
	var mhUniqueIdentifier: String
	var mhTitle: String
	var mhContentDescription: String
	var mhKeywords: Array<String>
	var mhImageInfo: MHImageInfo?
	var mhUserInfo:[String: NSSecureCoding]?
	var mhEligibleForSearch:Bool
	var mhEligibleForPublicIndexing:Bool
	var mhEligibleForHandoff:Bool
	var mhWebpageURL:NSURL?
	//var expirationDate:NSDate
	
	override init() {
		self.mhDomainIdentifier = ""
		self.mhUniqueIdentifier = ""
		self.mhTitle = ""
		self.mhContentDescription = ""
		self.mhKeywords = []
		self.mhEligibleForSearch = false
		self.mhEligibleForPublicIndexing = false
		self.mhEligibleForHandoff = false
        //self.mhExpirationDate = NSDate().dateByAddingTimeInterval(24 * 60 * 60 * 10)
		super.init()
	}
}
