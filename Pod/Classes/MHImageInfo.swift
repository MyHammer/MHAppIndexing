//
//  MHImageInfo.swift
//  Pods
//
//  Created by Andre Hess on 17.02.16.
//
//

import UIKit

/// Class contains image information used in protocol **MHCoreSpotlightObject**
public class MHImageInfo: NSObject {
	var bundleImageName : String?
	var bundleImageType : String?
	var assetImageName : String?
    var imageURL: NSURL?
	
	/**
	
	Init class by setting its bundle image name and type
	
	- parameter bundleImageName: Name of image in resource bundle
	- parameter bundleImageType: File type of image in resource bundle (e.g. "png")
	
	*/
	public init(bundleImageName:String, bundleImageType:String) {
		self.bundleImageName = bundleImageName
		self.bundleImageType = bundleImageType
		super.init()
	}
	
	/**
	
	Init class by setting its asset image name
	
	- parameter assetImageName: Name of image in xcassets
	
	*/
	public init(assetImageName:String) {
		self.assetImageName = assetImageName
		super.init()
	}
    
	/**
	
	Init class by setting image url
	
	- parameter imageURL: URL to image
	
	*/
	public init(imageURL:NSURL) {
        self.imageURL = imageURL
        super.init()
    }
}
