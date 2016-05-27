//
//  TestObjekt.swift
//  MHAppIndexing
//
//  Created by Frank Lienkamp on 27.05.16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import UIKit
import MHAppIndexing
import CoreSpotlight
import MobileCoreServices

class TestObjekt: NSObject, MHUserActivityObject {
    
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
    var mhExpirationDate:NSDate
    var mhAttributeSet:CSSearchableItemAttributeSet
    
    override init() {
        self.mhDomainIdentifier = ""
        self.mhUniqueIdentifier = ""
        self.mhTitle = ""
        self.mhContentDescription = ""
        self.mhKeywords = []
        self.mhEligibleForSearch = false
        self.mhEligibleForPublicIndexing = false
        self.mhEligibleForHandoff = false
        self.mhExpirationDate = NSDate().dateByAddingTimeInterval(24 * 60 * 60 * 1) //1 day
        self.mhAttributeSet = CSSearchableItemAttributeSet(itemContentType: kUTTypeImage as String)
        super.init()
    }
}
