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

public class MHCoreSpotlightManager: NSObject {
    
    public static let sharedInstance = MHCoreSpotlightManager()
    
    override init() {
        super.init()
    }
    
    public func addObjectToSearchIndex(searchObject: MHCoreSpotlightObject) {
        var attributes = searchObject.attributeSet
        if attributes == nil {
            attributes = CSSearchableItemAttributeSet(itemContentType: kUTTypeImage as String)
        }
        
        attributes!.relatedUniqueIdentifier = searchObject.uniqueIdentifier
        attributes!.title = searchObject.title
        attributes!.contentDescription = searchObject.contentDescription
        attributes!.keywords = searchObject.keywords
		
		if let imageInfo:MHImageInfo = searchObject.imageInfo {
			if let assetFilename = imageInfo.assetImageName {
				if let image = UIImage(named: assetFilename) {
					let imageData = UIImagePNGRepresentation(image)
					attributes!.thumbnailData = imageData
				}
			} else if let imageFileName = NSBundle.mainBundle().pathForResource(imageInfo.bundleImageName, ofType: imageInfo.bundleImageType) {
				attributes!.thumbnailURL = NSURL.fileURLWithPath(imageFileName)
			}
		}
        
		let expirationDate = self.expirationDateFromSearchObject(searchObject)
		addSearchableItemToCoreSpotlight(searchObject.uniqueIdentifier, domainId: searchObject.domainIdentifier, attributes: attributes!, expirationDate: expirationDate)
    }
    
    func expirationDateFromSearchObject(searchObject: MHCoreSpotlightObject) -> NSDate {
        var expDate: NSDate
        
        if let soExpDate = searchObject.expirationDate {
            expDate = soExpDate
        } else {
            let dateNow: NSDate = NSDate()
            let timeInterval: NSTimeInterval = NSTimeInterval(60 * 60 * 24 * searchItemDaysTillExpiration)
            expDate = dateNow.dateByAddingTimeInterval(timeInterval)
        }
        
        return expDate
    }
    
    func addSearchableItemToCoreSpotlight(uniqueId: String, domainId: String, attributes: CSSearchableItemAttributeSet, expirationDate: NSDate) {
        let uniqueIdentifier = domainId + ":" + uniqueId
        let item: CSSearchableItem = CSSearchableItem(uniqueIdentifier: uniqueIdentifier, domainIdentifier: domainId, attributeSet: attributes)
        //if let expDate = expirationDate {
        item.expirationDate = expirationDate
//        } else {
//            let dateNow: NSDate = NSDate()
//            let timeInterval: NSTimeInterval = NSTimeInterval(60 * 60 * 24 * searchItemDaysTillExpiration)
//            item.expirationDate = dateNow.dateByAddingTimeInterval(timeInterval)
//        }
		CSSearchableIndex.defaultSearchableIndex().indexSearchableItems([item]) { (error: NSError?) -> Void in
			if (error != nil) {
				NSLog("Search item NOT indexed because error: " + (error?.description)!);
			} else {
				if let attributesTitle = attributes.title {
					NSLog("Search item indexed with title: " + attributesTitle);
				} else {
					NSLog("Search item indexed with unique identifier: " + uniqueIdentifier);
				}
			}
		}
    }
}
