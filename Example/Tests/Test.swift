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
}
