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
        let attributes: CSSearchableItemAttributeSet = CSSearchableItemAttributeSet(itemContentType: kUTTypeImage as String)
        attributes.relatedUniqueIdentifier = searchObject.uniqueIdentifier
        attributes.title = searchObject.title
        attributes.contentDescription = searchObject.contentDescription
        attributes.keywords = searchObject.keywords
		
		if let imageInfo:MHImageInfo = searchObject.imageInfo {
			if let assetFilename = imageInfo.assetImageName {
				if let image = UIImage(named: assetFilename) {
					let imageData = UIImagePNGRepresentation(image)
					attributes.thumbnailData = imageData
				}
			} else if let imageFileName = NSBundle.mainBundle().pathForResource(imageInfo.bundleImageName, ofType: imageInfo.bundleImageType) {
				attributes.thumbnailURL = NSURL.fileURLWithPath(imageFileName)
			}
		}
		
		addSearchableItemToCoreSpotlight(searchObject.uniqueIdentifier, domainId: searchObject.domainIdentifier, attributes: attributes)
    }
    
    func addSearchableItemToCoreSpotlight(uniqueId: String, domainId: String, attributes: CSSearchableItemAttributeSet) {
        let uniqueIdentifier = domainId + ":" + uniqueId
        let item: CSSearchableItem = CSSearchableItem(uniqueIdentifier: uniqueIdentifier, domainIdentifier: domainId, attributeSet: attributes)
        //TODO: read date from MHCoreSpotlightObject
        let expDate: NSDate = NSDate()
        let timeInterval: NSTimeInterval = NSTimeInterval(60 * 60 * 24 * searchItemDaysTillExpiration)
        item.expirationDate = expDate.dateByAddingTimeInterval(timeInterval)
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
