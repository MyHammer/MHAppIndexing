//
//  MHCoreSpotlightObject.swift
//  Pods
//
//  Created by Frank Lienkamp on 12.02.16.
//
//

import Foundation

protocol MHCoreSpotlightObject {

    var domainIdentifier: String { get }
    var uniqueIdentifier: String { get }
    var title: String { get }
    var contentDescription: String { get }
    var keywords: Array<String> { get }

}