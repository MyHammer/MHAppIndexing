//
//  MHCoreSpotlightManagerTest.swift
//  MHAppIndexing
//
//  Created by Andre Hess on 27.05.16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import XCTest
import Nimble
import CoreSpotlight
import MobileCoreServices

@testable import MHAppIndexing

class MHCoreSpotlightManagerTest: XCTestCase {
    
    var spotlightManager = MHCoreSpotlightManager.sharedInstance
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testLoadImageFromImageInfoOnAddObjectToSearchIndex() {
        class TestManager:MHCoreSpotlightManager {
            var wasMethodCalled = false
            var resultImageInfo: MHImageInfo!
            var resultAttributes: CSSearchableItemAttributeSet!
            
            override func loadImageFromImageInfo(imageInfo: MHImageInfo?, attributes: CSSearchableItemAttributeSet, completion: ((Void) -> Void)?) {
                self.wasMethodCalled = true
                self.resultImageInfo = imageInfo
                self.resultAttributes = attributes
            }
        }
        
        let testManager = TestManager()
        let searchObject = TestObjekt()
        searchObject.mhImageInfo = MHImageInfo(assetImageName: "testImage")
        searchObject.mhAttributeSet = CSSearchableItemAttributeSet(itemContentType: kUTTypeImage as String)
        
        testManager.addObjectToSearchIndex(searchObject)
        
        expect(testManager.wasMethodCalled).to(equal(true))
        expect(testManager.resultImageInfo).to(equal(searchObject.mhImageInfo))
        expect(testManager.resultAttributes).to(equal(searchObject.mhAttributeSet))
    }
    
    func testAddSearchableItemToCoreSpotlightOnAddObjectToSearchIndex() {
        class TestManager:MHCoreSpotlightManager {
            var wasMethodCalled = false
            var resultUniqueId: String!
            var resultDomainId: String!
            var resultAttributes: CSSearchableItemAttributeSet!
            var resultExpirationDate: NSDate!
            
            override func addSearchableItemToCoreSpotlight(uniqueId: String, domainId: String, attributes: CSSearchableItemAttributeSet, expirationDate: NSDate) {
                self.wasMethodCalled = true
                self.resultUniqueId = uniqueId
                self.resultDomainId = domainId
                self.resultAttributes = attributes
                self.resultExpirationDate = expirationDate
            }
        }
        let testManager = TestManager()
        let searchObject = TestObjekt()
        searchObject.mhUniqueIdentifier = "123"
        searchObject.mhDomainIdentifier = "456"
        searchObject.mhAttributeSet = CSSearchableItemAttributeSet(itemContentType: kUTTypeImage as String)
        searchObject.mhExpirationDate = NSDate()
        
        testManager.addObjectToSearchIndex(searchObject)
        
        expect(testManager.wasMethodCalled).to(equal(true))
        expect(testManager.resultUniqueId).to(equal(searchObject.mhUniqueIdentifier))
        expect(testManager.resultDomainId).to(equal(searchObject.mhDomainIdentifier))
        expect(testManager.resultAttributes).to(equal(searchObject.mhAttributeSet))
        expect(testManager.resultExpirationDate).to(equal(searchObject.mhExpirationDate))
    }
    
    func testExpirationDateFromSearchObjectWithGivenDate() {
        let searchObject = TestObjekt()
        searchObject.mhExpirationDate = NSDate()
        expect(self.spotlightManager.expirationDateFromSearchObject(searchObject)).to(equal(searchObject.mhExpirationDate))
    }
    
    func testIndexSearchableItemsOnAddSearchableItemToCoreSpotlight() {
        class TestIndex:CSSearchableIndex {
            var wasMethodCalled = false
            var resultItem: CSSearchableItem!
            
            override func indexSearchableItems(items: [CSSearchableItem], completionHandler: ((NSError?) -> Void)?) {
                self.wasMethodCalled = true
                self.resultItem = items[0]
            }
        }
        class TestManager:MHCoreSpotlightManager {
            let testIndex = TestIndex()
            
            override func searchableIndex() -> CSSearchableIndex {
                return self.testIndex
            }
        }
        
        let testManager = TestManager()
        let testIndex = testManager.searchableIndex() as! TestIndex
        let uniqueId = "123"
        let domainId = "456"
        let attributes = CSSearchableItemAttributeSet(itemContentType: kUTTypeImage as String)
        let expirationDate = NSDate()
        
        testManager.addSearchableItemToCoreSpotlight(uniqueId, domainId: domainId, attributes: attributes, expirationDate: expirationDate)
        
        expect(testIndex.wasMethodCalled).to(equal(true))
        expect(testIndex.resultItem.uniqueIdentifier).to(equal(domainId + ":" + uniqueId))
        expect(testIndex.resultItem.domainIdentifier).to(equal(domainId))
        expect(testIndex.resultItem.attributeSet).to(equal(attributes))
        expect(testIndex.resultItem.expirationDate).to(equal(expirationDate))
    }
    
}
