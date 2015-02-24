//
//  Tracker.swift
//  localHemp
//
//  Created by Nicolas Grenie on 2/23/15.
//  Copyright (c) 2015 Nicolas Grenie. All rights reserved.
//

import Foundation

public class Tracker{
    let defaults = NSUserDefaults.standardUserDefaults()
    let session: NSURLSession
    let URL = "https://api.bitcoinaverage.com/ticker/USD"
    
    public init() {
        let configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
        session = NSURLSession(configuration: configuration);
    }
}