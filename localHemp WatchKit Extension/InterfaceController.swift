//
//  InterfaceController.swift
//  localHemp WatchKit Extension
//
//  Created by Nicolas Grenie on 2/23/15.
//  Copyright (c) 2015 Nicolas Grenie. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {
    
    let location = CLLocationCoordinate2D(latitude: 37, longitude: -122)
    let tracker = Tracker()
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        // Configure interface objects here.
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    override func contextForSegueWithIdentifier(segueIdentifier: String) ->
        AnyObject? {
            println(segueIdentifier)
            if segueIdentifier == "pagebased" {
                return ["segue": "pagebased",
                "data": "Passed through page-based navigation"]
            } else {
                return ["segue": "", "data": ""]
            }
    }

}
