//
//  ViewController.swift
//  MHAppIndexing
//
//  Created by Frank Lienkamp on 02/03/2016.
//  Copyright (c) 2016 Frank Lienkamp. All rights reserved.
//

import UIKit
import MHAppIndexing

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

	
	@IBAction func indexCoreSpotlightObjects(sender: AnyObject) {
		let exampleOne  = self.exampleObject1()
        let exampleTwo  = self.exampleObject2()
        let exampleThree  = self.exampleObject3()
		
		MHCoreSpotlightManager.sharedInstance.addObjectToSearchIndex(exampleOne)
        MHCoreSpotlightManager.sharedInstance.addObjectToSearchIndex(exampleTwo)
        MHCoreSpotlightManager.sharedInstance.addObjectToSearchIndex(exampleThree)
	}
	
	@IBAction func indexUserActivityObjects(sender: AnyObject) {
		let exampleOne  = self.exampleObject1()
		let exampleTwo  = self.exampleObject2()
		let exampleThree  = self.exampleObject3()
		
		MHUserActivityManager.sharedInstance.addObjectToSearchIndex(exampleOne)
		MHUserActivityManager.sharedInstance.addObjectToSearchIndex(exampleTwo)
		MHUserActivityManager.sharedInstance.addObjectToSearchIndex(exampleThree)
	}
	
	/*
		// MARK: - example creation methods
	*/
	
    
    func exampleObject1() -> ExampleObject {
        let example  = ExampleObject()
        example.mhDomainIdentifier = "com.some.what.here"
        example.mhUniqueIdentifier = "1234567891"
        example.mhTitle = "Lisa"
        example.mhContentDescription = "This is a content description for Lisa"
        example.mhKeywords = ["apple", "cherry", "banana"]
        example.mhImageInfo = MHImageInfo(imageURL: NSURL(string: "https://upload.wikimedia.org/wikipedia/en/e/ec/Lisa_Simpson.png")!)
        
        //UserActivity stuff
        example.mhUserInfo = ["objectId":example.mhUniqueIdentifier]
        example.mhEligibleForSearch = true
        example.mhEligibleForPublicIndexing = true
        example.mhEligibleForHandoff = false
        example.mhWebpageURL = NSURL(string: "https://en.wikipedia.org/wiki/Lisa_Simpson")
        
        return example
    }
    
    func exampleObject2() -> ExampleObject {
        let example  = ExampleObject()
        example.mhDomainIdentifier = "com.some.what.here"
        example.mhUniqueIdentifier = "987654321"
        example.mhTitle = "Homer"
        example.mhContentDescription = "Here is a content description for Homer"
        example.mhKeywords = ["orange", "melon", "pineapple"]
        example.mhImageInfo = MHImageInfo(bundleImageName: "homer", bundleImageType: "png")
        
        //UserActivity stuff
        example.mhUserInfo = ["objectId":example.mhUniqueIdentifier]
        example.mhEligibleForSearch = true
        example.mhEligibleForPublicIndexing = true
        example.mhEligibleForHandoff = false
        example.mhWebpageURL = NSURL(string: "https://en.wikipedia.org/wiki/Homer_Simpson")
        
        return example
    }
    
    func exampleObject3() -> ExampleObject {
        let example  = ExampleObject()
        example.mhDomainIdentifier = "com.some.what.here"
        example.mhUniqueIdentifier = "47110822"
        example.mhTitle = "Carl"
        example.mhContentDescription = "Content description here for Carl"
        example.mhKeywords = ["strawberry", "kiwi", "lemon"]
        example.mhImageInfo = MHImageInfo(assetImageName: "carl")
        
        //UserActivity stuff
        example.mhUserInfo = ["objectId":example.mhUniqueIdentifier]
        example.mhEligibleForSearch = true
        example.mhEligibleForPublicIndexing = true
        example.mhEligibleForHandoff = false
        example.mhWebpageURL = NSURL(string: "https://en.wikipedia.org/wiki/Lenny_and_Carl#Carl_Carlson")
        
        return example
    }
}

