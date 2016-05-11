//
//  MHUserActivityManager.swift
//  Pods
//
//  Created by Andre Hess on 17.02.16.
//
//

import UIKit
import CoreSpotlight
import MobileCoreServices

let userActivityActivationDelay = 2.0

@available(iOS 9.0, *)
public class MHUserActivityManager: NSObject, NSUserActivityDelegate {
	
	public static let sharedInstance = MHUserActivityManager()
	var activities: NSMutableArray
    var didStartMakingActivitiesCurrent = false
	
	override init() {
		self.activities = []
		super.init()
	}
	
	public func addObjectToSearchIndex(searchObject: MHUserActivityObject) {
		let activityType = searchObject.mhDomainIdentifier + ":" + searchObject.mhUniqueIdentifier
		let userActivity = NSUserActivity(activityType: activityType)
		userActivity.title = searchObject.mhTitle
		userActivity.userInfo = searchObject.mhUserInfo
		userActivity.eligibleForSearch = searchObject.mhEligibleForSearch
		userActivity.eligibleForPublicIndexing = searchObject.mhEligibleForPublicIndexing
		userActivity.eligibleForHandoff = searchObject.mhEligibleForHandoff
		userActivity.webpageURL = searchObject.mhWebpageURL
		if let expDate = searchObject.mhExpirationDate {
			userActivity.expirationDate = expDate
		} else {
			let dateNow: NSDate = NSDate()
			let timeInterval: NSTimeInterval = NSTimeInterval(60 * 60 * 24 * searchItemDaysTillExpiration)
			userActivity.expirationDate = dateNow.dateByAddingTimeInterval(timeInterval)
		}
        userActivity.delegate = self
        self.contentAttributeSetFromSearchObject(searchObject, completion: { (attributeSet:CSSearchableItemAttributeSet) in
            userActivity.contentAttributeSet = attributeSet
            self.makeActivityCurrent(userActivity)
        })
	}
	
    func contentAttributeSetFromSearchObject(searchObject: MHUserActivityObject, completion: ((attributeSet:CSSearchableItemAttributeSet)->Void)?) {
		var attributes = searchObject.mhAttributeSet
        if attributes == nil {
            attributes = CSSearchableItemAttributeSet(itemContentType: kUTTypeImage as String)
        }
        attributes!.relatedUniqueIdentifier = searchObject.mhUniqueIdentifier
		attributes!.title = searchObject.mhTitle
		attributes!.contentDescription = searchObject.mhContentDescription
		attributes!.keywords = searchObject.mhKeywords
        self.loadImageFromImageInfo(searchObject.mhImageInfo, attributes: attributes!, completion: completion)
    }
	
    func loadImageFromImageInfo(imageInfo:MHImageInfo?, attributes:CSSearchableItemAttributeSet, completion:((attributeSet:CSSearchableItemAttributeSet)->Void)?) {
		if let info:MHImageInfo = imageInfo {
			if let assetFilename = info.assetImageName {
				if let image = UIImage(named: assetFilename) {
					let imageData = UIImagePNGRepresentation(image)
					attributes.thumbnailData = imageData
				}
                completion?(attributeSet: attributes)
			} else if let imageFileName = NSBundle.mainBundle().pathForResource(info.bundleImageName, ofType: info.bundleImageType) {
				attributes.thumbnailURL = NSURL.fileURLWithPath(imageFileName)
                completion?(attributeSet: attributes)
            } else if let imageURL = info.imageURL {
                UIImage.loadImageAsyncFromURL(imageURL, completion: { (result:UIImage?) in
                    if let image = result {
                        attributes.thumbnailData = UIImagePNGRepresentation(image)
                    }
                    completion?(attributeSet: attributes)
                })
            } else {
                completion?(attributeSet: attributes)
            }
        } else {
            completion?(attributeSet: attributes)
        }
	}
	
	func makeActivityCurrent(activity: NSUserActivity) {
		self.activities.addObject(activity)
        if (!self.didStartMakingActivitiesCurrent) {
            self.didStartMakingActivitiesCurrent = true
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(userActivityActivationDelay * Double(NSEC_PER_SEC))), dispatch_get_main_queue()) { () -> Void in
                self.makeFirstActivityCurrent()
            }
        }
	}
    
    func makeFirstActivityCurrent() {
        let firstActivity = self.activities.firstObject
        firstActivity?.becomeCurrent()
        if let activityTitle = firstActivity?.mhTitle {
            NSLog("UserActivity will become current with title: " + activityTitle)
        } else {
            NSLog("UserActivity will become current")
        }
    }
	
	// MARK: - NSUserActivityDelegate methods
	
	public func userActivityWillSave(userActivity: NSUserActivity) {
        if let activityTitle = userActivity.title {
            NSLog("UserActivity will save with title: " + activityTitle)
        } else {
            NSLog("UserActivity will save")
        }
        if self.activities.count > 0 {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(userActivityActivationDelay * Double(NSEC_PER_SEC))), dispatch_get_main_queue()) { () -> Void in
                self.activities.removeObject(userActivity)
                if self.activities.count > 0 {
                    self.makeFirstActivityCurrent()
                } else {
                    self.didStartMakingActivitiesCurrent = false
                }
            }
        } else {
            self.didStartMakingActivitiesCurrent = false
        }
	}
}
