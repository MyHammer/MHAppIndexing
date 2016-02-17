//
//  MHImageInfo.swift
//  Pods
//
//  Created by Andre Hess on 17.02.16.
//
//

import UIKit

public class MHImageInfo: NSObject {
	var bundleImageName : String?
	var bundleImageType : String?
	var assetImageName : String?
	
	public init(bundleImageName:String, bundleImageType:String) {
		self.bundleImageName = bundleImageName
		self.bundleImageType = bundleImageType
		super.init()
	}
	
	public init(assetImageName:String) {
		self.assetImageName = assetImageName
		super.init()
	}
	
	//TODO: Async image loading
}
