//
//  Test.swift
//  MHAppIndexing
//
//  Created by Frank Lienkamp on 03.02.16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import XCTest
import Nimble

@testable import MHAppIndexing

class Test: XCTestCase {

	let activityManager = MHUserActivityManager.sharedInstance
	var userActivity:NSUserActivity!
	
    override func setUp() {
		super.setUp()
		self.activityManager.activities = []
    }
    
    override func tearDown() {
        super.tearDown()
    }

    func testExample() {
        expect(1 + 1).to(equal(2))
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
}
