//
//  MHUserActivityManagerTest.swift
//  MHAppIndexing
//
//  Created by Andre Hess on 27.05.16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import XCTest
import Nimble
import CoreSpotlight

@testable import MHAppIndexing

class MHUserActivityManagerTest: XCTestCase {

	let activityManager = MHUserActivityManager.sharedInstance
	var userActivity:NSUserActivity!
	
    override func setUp() {
        super.setUp()
        self.activityManager.activities = []
    }
    
    override func tearDown() {
        super.tearDown()
    }
	
	func testContentAttributeSetFromSearchObjectOnAddObjectToSearchIndex() {
		class TestUserActivityManager:MHUserActivityManager {
			var contentAttributeSetFromSearchObjectWasCalled = false
			override func contentAttributeSetFromSearchObject(searchObject: MHUserActivityObject, completion: ((attributeSet: CSSearchableItemAttributeSet) -> Void)?) {
				contentAttributeSetFromSearchObjectWasCalled = true
			}
		}
		let testObject:BeispielTestObjekt = BeispielTestObjekt()
		let testActivityManager = TestUserActivityManager()
		testActivityManager.addObjectToSearchIndex(testObject)
		expect(testActivityManager.contentAttributeSetFromSearchObjectWasCalled).to(equal(true))
	}

	func testSettingCorrectValuesOnAddObjectToSearchIndex() {
		class TestUserActivityManager:MHUserActivityManager {
			var activityTypeString:String!
			var testUserActivity:NSUserActivity! 
			override func createUserActivity(activityType:String) -> NSUserActivity {
				testUserActivity = NSUserActivity(activityType:activityType)
				return testUserActivity
			}
		}
		let testObject:BeispielTestObjekt = BeispielTestObjekt() 
		testObject.mhDomainIdentifier = "com.sowas.tolles.hier"
		testObject.mhUniqueIdentifier = "1234567891"
		testObject.mhTitle = "Beispiel26"
		testObject.mhContentDescription = "Hier steht die ContentDescription1"
		testObject.mhWebpageURL = NSURL(string:"https://www.leo.org")
		testObject.mhEligibleForSearch = true
		testObject.mhUserInfo = ["userInfoKey": "userInfoValue"]
		let testActivityManager = TestUserActivityManager()
		testActivityManager.addObjectToSearchIndex(testObject)
		expect(testActivityManager.testUserActivity.title).to(equal(testObject.mhTitle))
		expect(testActivityManager.testUserActivity.activityType).to(equal(testObject.mhDomainIdentifier+":"+testObject.mhUniqueIdentifier))
		expect(testActivityManager.testUserActivity.eligibleForSearch).to(equal(true))
		expect(testActivityManager.testUserActivity.eligibleForPublicIndexing).to(equal(false))
		expect(testActivityManager.testUserActivity.eligibleForHandoff).to(equal(false))
		expect(testActivityManager.testUserActivity.webpageURL).to(equal(testObject.mhWebpageURL))
	}
	
	func testLoadImageFromImageInfoOnContentAttributeSetFromSearchObject() {
		class TestUserActivityManager:MHUserActivityManager {
			var loadImageFromImageInfoCalled = false
			override func loadImageFromImageInfo(imageInfo: MHImageInfo?, attributes: CSSearchableItemAttributeSet, completion: ((attributeSet: CSSearchableItemAttributeSet) -> Void)?) {
				loadImageFromImageInfoCalled = true
			}
		}
		let testObject:BeispielTestObjekt = BeispielTestObjekt()
		let testActivityManager = TestUserActivityManager()
		testActivityManager.addObjectToSearchIndex(testObject)
		expect(testActivityManager.loadImageFromImageInfoCalled).to(equal(true))
	}
	
	func testSettingAttributesOfAttributeSetCorrectlyOnAddObjectToSearchIndexCompletely() {
		let testObject:BeispielTestObjekt = BeispielTestObjekt() 
		testObject.mhDomainIdentifier = "com.sowas.tolles.hier"
		testObject.mhUniqueIdentifier = "1234567891"
		testObject.mhTitle = "Beispiel26"
		testObject.mhContentDescription = "Hier steht die ContentDescription1"
		testObject.mhKeywords = ["apfel", "birne", "banane"]
		testObject.mhImageInfo = MHImageInfo(assetImageName:"homer")
		testObject.mhEligibleForSearch = true
		class TestUserActivityManager:MHUserActivityManager {
			override func makeActivityCurrent(activity: NSUserActivity) {
				expect(activity.contentAttributeSet!.relatedUniqueIdentifier).to(equal("1234567891"))
				expect(activity.contentAttributeSet!.title).to(equal("Beispiel26"))
				expect(activity.contentAttributeSet!.contentDescription).to(equal("Hier steht die ContentDescription1"))
				expect(activity.contentAttributeSet!.keywords).to(equal(["apfel", "birne", "banane"]))
			}
		}
		let testActivityManager = TestUserActivityManager()
		testActivityManager.addObjectToSearchIndex(testObject)
	}
		
	func testAddingObjectToActivitiesOnMakeActivityCurrent() {
		self.userActivity = NSUserActivity(activityType:"TestActivity")
		self.activityManager.makeActivityCurrent(userActivity)
		expect(self.activityManager.activities.count).to(equal(1))
	}
	
	func testAddObjectOnMakeActivityCurrent() {
		class TestArray:NSMutableArray {
			var addObjectWasCalled = false
			
			override func addObject(anObject: AnyObject) {
				addObjectWasCalled = true
			}
		}
		let testActivities:TestArray = TestArray()
		self.userActivity = NSUserActivity(activityType:"TestActivity")
		self.activityManager.activities = testActivities
		self.activityManager.makeActivityCurrent(userActivity)
		expect(testActivities.addObjectWasCalled).to(equal(true))
	}

	func testBecomeCurrentOnMakeFirstActivityCurrent() {
		class TestUserActivity:NSUserActivity {
			var becomeCurrentCalled = false
			override func becomeCurrent() {
				becomeCurrentCalled = true
			}
		}
		let testActivity = TestUserActivity(activityType:"TestActivity")
		self.activityManager.activities = [testActivity]
		self.activityManager.makeFirstActivityCurrent()
		expect(testActivity.becomeCurrentCalled).to(equal(true))
	}
	
}
