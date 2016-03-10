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
		let beispielEins  = self.beispielObjekt1()
        let beispielZwei  = self.beispielObjekt2()
        let beispielDrei  = self.beispielObjekt3()
		
		//MHCoreSpotlightManager.sharedInstance.addObjectToSearchIndex(beispielEins)
		
        MHUserActivityManager.sharedInstance.addObjectToSearchIndex(beispielEins)
        MHUserActivityManager.sharedInstance.addObjectToSearchIndex(beispielZwei)
        MHUserActivityManager.sharedInstance.addObjectToSearchIndex(beispielDrei)
	}
    
    func beispielObjekt1() -> BeispielTestObjekt {
        let beispiel  = BeispielTestObjekt()
        beispiel.domainIdentifier = "com.sowas.tolles.hier"
        beispiel.uniqueIdentifier = "123456789"
        beispiel.title = "Beispiel7"
        beispiel.contentDescription = "Hier steht die ContentDescription1"
        beispiel.keywords = ["apfel", "birne", "banane"]
        //beispiel.imageInfo = MHImageInfo(bundleImageName: "homer", bundleImageType: "png")
        beispiel.imageInfo = MHImageInfo(assetImageName: "homer")
        
        //UserActivity stuff
        beispiel.userInfo = ["objectId":beispiel.uniqueIdentifier]
        beispiel.eligibleForSearch = true
        beispiel.eligibleForPublicIndexing = true
        beispiel.eligibleForHandoff = false
        beispiel.webpageURL = NSURL(string: "https://www.myhammer.de/" + beispiel.uniqueIdentifier)
        
        return beispiel
    }
    
    func beispielObjekt2() -> BeispielTestObjekt {
        let beispiel  = BeispielTestObjekt()
        beispiel.domainIdentifier = "com.sowas.tolles.hier"
        beispiel.uniqueIdentifier = "987654321"
        beispiel.title = "Beispiel8"
        beispiel.contentDescription = "Hier steht die ContentDescription2"
        beispiel.keywords = ["orange", "melone", "ananas"]
        //beispiel.imageInfo = MHImageInfo(bundleImageName: "homer", bundleImageType: "png")
        beispiel.imageInfo = MHImageInfo(assetImageName: "carl")
        
        //UserActivity stuff
        beispiel.userInfo = ["objectId":beispiel.uniqueIdentifier]
        beispiel.eligibleForSearch = true
        beispiel.eligibleForPublicIndexing = true
        beispiel.eligibleForHandoff = false
        beispiel.webpageURL = NSURL(string: "https://www.myhammer.de/" + beispiel.uniqueIdentifier)
        
        return beispiel
    }
    
    func beispielObjekt3() -> BeispielTestObjekt {
        let beispiel  = BeispielTestObjekt()
        beispiel.domainIdentifier = "com.sowas.tolles.hier"
        beispiel.uniqueIdentifier = "47110822"
        beispiel.title = "Beispiel9"
        beispiel.contentDescription = "Hier steht die ContentDescription3"
        beispiel.keywords = ["erdbeere", "kiwi", "zitrone"]
        //beispiel.imageInfo = MHImageInfo(bundleImageName: "homer", bundleImageType: "png")
        beispiel.imageInfo = MHImageInfo(assetImageName: "carl")
        
        //UserActivity stuff
        beispiel.userInfo = ["objectId":beispiel.uniqueIdentifier]
        beispiel.eligibleForSearch = true
        beispiel.eligibleForPublicIndexing = true
        beispiel.eligibleForHandoff = false
        beispiel.webpageURL = NSURL(string: "https://www.myhammer.de/" + beispiel.uniqueIdentifier)
        
        return beispiel
    }
}

