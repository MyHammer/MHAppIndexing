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
		
	//	MHCoreSpotlightManager.sharedInstance.addObjectToSearchIndex(beispielEins)
        MHCoreSpotlightManager.sharedInstance.addObjectToSearchIndex(beispielZwei)
        MHCoreSpotlightManager.sharedInstance.addObjectToSearchIndex(beispielDrei)
		
        MHUserActivityManager.sharedInstance.addObjectToSearchIndex(beispielEins)
//        MHUserActivityManager.sharedInstance.addObjectToSearchIndex(beispielZwei)
//        MHUserActivityManager.sharedInstance.addObjectToSearchIndex(beispielDrei)
	}
    
    func beispielObjekt1() -> BeispielTestObjekt {
        let beispiel  = BeispielTestObjekt()
        beispiel.mhDomainIdentifier = "com.sowas.tolles.hier"
        beispiel.mhUniqueIdentifier = "1234567891"
        beispiel.mhTitle = "Beispiel26"
        beispiel.mhContentDescription = "Hier steht die ContentDescription1"
        beispiel.mhKeywords = ["apfel", "birne", "banane"]
        //beispiel.mhImageInfo = MHImageInfo(bundleImageName: "homer", bundleImageType: "png")
        //beispiel.mhImageInfo = MHImageInfo(assetImageName: "homer")
        beispiel.mhImageInfo = MHImageInfo(imageURL: NSURL(string: "https://e.myhcdn.net/v3/thumbs/profileSmallV2/cc/c/1691707.gif?")!)
        
        //UserActivity stuff
        beispiel.mhUserInfo = ["objectId":beispiel.mhUniqueIdentifier]
        beispiel.mhEligibleForSearch = true
        beispiel.mhEligibleForPublicIndexing = true
        beispiel.mhEligibleForHandoff = false
        beispiel.mhWebpageURL = NSURL(string: "https://www.myhammer.de/" + beispiel.mhUniqueIdentifier)
        
        return beispiel
    }
    
    func beispielObjekt2() -> BeispielTestObjekt {
        let beispiel  = BeispielTestObjekt()
        beispiel.mhDomainIdentifier = "com.sowas.tolles.hier"
        beispiel.mhUniqueIdentifier = "987654321"
        beispiel.mhTitle = "Beispiel20"
        beispiel.mhContentDescription = "Hier steht die ContentDescription2"
        beispiel.mhKeywords = ["orange", "melone", "ananas"]
        //beispiel.mhImageInfo = MHImageInfo(bundleImageName: "homer", bundleImageType: "png")
        beispiel.mhImageInfo = MHImageInfo(assetImageName: "carl")
        
        //UserActivity stuff
        beispiel.mhUserInfo = ["objectId":beispiel.mhUniqueIdentifier]
        beispiel.mhEligibleForSearch = true
        beispiel.mhEligibleForPublicIndexing = true
        beispiel.mhEligibleForHandoff = false
        beispiel.mhWebpageURL = NSURL(string: "https://www.myhammer.de/" + beispiel.mhUniqueIdentifier)
        
        return beispiel
    }
    
    func beispielObjekt3() -> BeispielTestObjekt {
        let beispiel  = BeispielTestObjekt()
        beispiel.mhDomainIdentifier = "com.sowas.tolles.hier"
        beispiel.mhUniqueIdentifier = "47110822"
        beispiel.mhTitle = "Beispiel21"
        beispiel.mhContentDescription = "Hier steht die ContentDescription3"
        beispiel.mhKeywords = ["erdbeere", "kiwi", "zitrone"]
        //beispiel.mhImageInfo = MHImageInfo(bundleImageName: "homer", bundleImageType: "png")
        beispiel.mhImageInfo = MHImageInfo(assetImageName: "carl")
        
        //UserActivity stuff
        beispiel.mhUserInfo = ["objectId":beispiel.mhUniqueIdentifier]
        beispiel.mhEligibleForSearch = true
        beispiel.mhEligibleForPublicIndexing = true
        beispiel.mhEligibleForHandoff = false
        beispiel.mhWebpageURL = NSURL(string: "https://www.myhammer.de/" + beispiel.mhUniqueIdentifier)
        
        return beispiel
    }
}

