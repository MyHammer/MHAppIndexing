//
//  UIImage+AsyncLoad.swift
//  Pods
//
//  Created by Frank Lienkamp on 12.04.16.
//
//

import Foundation

extension UIImage {
    public static func loadImageAsyncFromURL(imageURL: NSURL, completion: ((resultImage:UIImage?)->Void)?) {
        print("Begin loading image async for url: " + String(imageURL))
        let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT
        dispatch_async(dispatch_get_global_queue(priority, 0), {
            var resultImage:UIImage?
            let imageData:NSData? = NSData(contentsOfURL: imageURL)
            if let data:NSData = imageData {
                resultImage = UIImage(data: data)
            }
            dispatch_async(dispatch_get_main_queue(), {
                print("Finished loading image async")
                completion?(resultImage: resultImage)
            })
        })
    }
}
