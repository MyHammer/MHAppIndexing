//
//  MHCoreSpotlightManager.swift
//  Pods
//
//  Created by Frank Lienkamp on 12.02.16.
//
//

import UIKit
import CoreSpotlight
import MobileCoreServices

let searchItemDaysTillExpiration = 30

class MHCoreSpotlightManager: NSObject {
    
    static let sharedInstance = MHCoreSpotlightManager()
    
    override init() {
        super.init()
    }
    
    func addObjectToSearchIndex(searchObject: MHCoreSpotlightObject) {
        let attributes: CSSearchableItemAttributeSet = CSSearchableItemAttributeSet(itemContentType: kUTTypeImage as String)
        attributes.relatedUniqueIdentifier = searchObject.uniqueIdentifier
        attributes.title = searchObject.title
        attributes.contentDescription = searchObject.contentDescription
        attributes.keywords = searchObject.keywords
        
    }
    
    func addSearchableItemToCoreSpotlight(uniqueId: String, domainId: String, attributes: CSSearchableItemAttributeSet) {
        let uniqueIdentifier = domainId + ":" + uniqueId
        let item: CSSearchableItem = CSSearchableItem(uniqueIdentifier: uniqueIdentifier, domainIdentifier: domainId, attributeSet: attributes)
        //TODO: read date from MHCoreSpotlightObject
        let expDate: NSDate = NSDate()
        let timeInterval: NSTimeInterval = NSTimeInterval(60 * 60 * 24 * searchItemDaysTillExpiration)
        item.expirationDate = expDate.dateByAddingTimeInterval(timeInterval)
    }
}
