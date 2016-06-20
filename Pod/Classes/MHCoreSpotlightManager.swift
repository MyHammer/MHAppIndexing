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


/// Manager for indexing objects that confirm to protocol **MHCoreSpotlightObject**
@available(iOS 9.0, *)
public class MHCoreSpotlightManager: NSObject {
    
	/// Factory method returning a shared instance of **MHCoreSpotlightManager**
    public static let sharedInstance = MHCoreSpotlightManager()
    
	/**
	
	Adding an object to search index
	
	- parameter searchObject: Object that confirms to protocol MHCoreSpotlightObject
	
	*/
    public func addObjectToSearchIndex(searchObject: MHCoreSpotlightObject) {
        var attributes = searchObject.mhAttributeSet
        if attributes == nil {
            attributes = CSSearchableItemAttributeSet(itemContentType: kUTTypeImage as String)
        }
        
        attributes!.relatedUniqueIdentifier = searchObject.mhUniqueIdentifier
        attributes!.title = searchObject.mhTitle
        attributes!.contentDescription = searchObject.mhContentDescription
        attributes!.keywords = searchObject.mhKeywords
		
		self.loadImageFromImageInfo(searchObject.mhImageInfo, attributes:attributes!) { (Void) in
            let expirationDate = self.expirationDateFromSearchObject(searchObject)
            self.addSearchableItemToCoreSpotlight(searchObject.mhUniqueIdentifier, domainId: searchObject.mhDomainIdentifier, attributes: attributes!, expirationDate: expirationDate)
        }
    }
	
    func expirationDateFromSearchObject(searchObject: MHCoreSpotlightObject) -> NSDate {
        var expDate: NSDate
        
        if let soExpDate = searchObject.mhExpirationDate {
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
        item.expirationDate = expirationDate

		self.searchableIndex().indexSearchableItems([item]) { (error: NSError?) -> Void in
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
    
    func loadImageFromImageInfo(imageInfo:MHImageInfo?, attributes:CSSearchableItemAttributeSet, completion: ((Void)->Void)?) {
        if let info:MHImageInfo = imageInfo {
            if let assetFilename = info.assetImageName {
                if let image = UIImage(named: assetFilename) {
                    let imageData = UIImagePNGRepresentation(image)
                    attributes.thumbnailData = imageData
                }
                completion?()
            } else if let imageFileName = NSBundle.mainBundle().pathForResource(info.bundleImageName, ofType: info.bundleImageType) {
                attributes.thumbnailURL = NSURL.fileURLWithPath(imageFileName)
                completion?()
            } else if let imageURL = info.imageURL {
                UIImage.loadImageAsyncFromURL(imageURL, completion: { (result:UIImage?) in
                    if let image = result {
                        attributes.thumbnailData = UIImagePNGRepresentation(image)
                    }
                    completion?()
                })
            } else {
                completion?()
            }
        } else {
            completion?()
        }
    }
    
    // MARK: - Helper methods
    
    func searchableIndex() -> CSSearchableIndex {
        return CSSearchableIndex.defaultSearchableIndex();
    }
    
}
