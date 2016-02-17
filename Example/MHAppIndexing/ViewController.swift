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
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

	
	@IBAction func legLosButtonTouched(sender: AnyObject) {
		let beispielEins  = BeispielTestObjekt()
		beispielEins.domainIdentifier = "com.sowas.tolles.hier"
		beispielEins.uniqueIdentifier = "47110820"
		beispielEins.title = "5Hat geklappt, das mit dem CoreSpotlight"
		beispielEins.contentDescription = "Hier steht die ContentDescription"
		beispielEins.keywords = ["apfel", "birne", "banane"]
		//beispielEins.imageInfo = MHImageInfo(bundleImageName: "homer", bundleImageType: "png")
		beispielEins.imageInfo = MHImageInfo(assetImageName: "carl")
		
		//UserActivity stuff
		beispielEins.userInfo = ["objectId":beispielEins.uniqueIdentifier]
		beispielEins.eligibleForSearch = true
		beispielEins.eligibleForPublicIndexing = true
		beispielEins.eligibleForHandoff = false
		beispielEins.webpageURL = NSURL(string: "https://www.myhammer.de")
		
		//MHCoreSpotlightManager.sharedInstance.addObjectToSearchIndex(beispielEins)
		MHUserActivityManager.sharedInstance.addObjectToSearchIndex(beispielEins)
	}
}

