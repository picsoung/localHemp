//
//  page2.swift
//  localHemp
//
//  Created by Nicolas Grenie on 2/23/15.
//  Copyright (c) 2015 Nicolas Grenie. All rights reserved.
//

import WatchKit
import Foundation

class Page2: WKInterfaceController {
    @IBOutlet weak var label: WKInterfaceLabel!
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        var segue = (context as! NSDictionary)["segue"] as? String
        var data = (context as! NSDictionary)["data"] as? String
        self.label.setText(data)
    }

    override func willActivate() {
        super.willActivate()
    }
    override func didDeactivate() {
        super.didDeactivate()
    }
}
