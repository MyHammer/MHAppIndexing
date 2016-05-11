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

@available(iOS 9.0, *)
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
		
		self.loadImageFromImageInfo(searchObject.imageInfo, attributes:attributes!) { (Void) in
            let expirationDate = self.expirationDateFromSearchObject(searchObject)
            self.addSearchableItemToCoreSpotlight(searchObject.uniqueIdentifier, domainId: searchObject.domainIdentifier, attributes: attributes!, expirationDate: expirationDate)
        }
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
        item.expirationDate = expirationDate

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
    
//    func loadImageAsyncFromURL(imageURL: NSURL, completion: ((resultImage:UIImage?)->Void)?) {
//        print("Begin loading image async for url: " + String(imageURL))
//        let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT
//        dispatch_async(dispatch_get_global_queue(priority, 0), {
//            var resultImage:UIImage?
//            let imageData:NSData? = NSData(contentsOfURL: imageURL)
//            if let data:NSData = imageData {
//                resultImage = UIImage(data: data)
//            }
//            dispatch_async(dispatch_get_main_queue(), {
//                print("Finished loading image async")
//                completion?(resultImage: resultImage)
//            })
//        })
//    }
}
