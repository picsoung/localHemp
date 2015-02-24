//
//  ViewController.swift
//  localHemp
//
//  Created by Nicolas Grenie on 2/23/15.
//  Copyright (c) 2015 Nicolas Grenie. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    let locationManager = CLLocationManager()
    
    @IBAction func clickHemp(sender: AnyObject) {
        println("jojo")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        CLGeocoder().reverseGeocodeLocation(manager.location, completionHandler: { (placemarks, error) -> Void in
            if(error != nil){
                println("Error:", error.localizedDescription)
            }
            
            if (placemarks.count>0){
                let pe = placemarks[0] as! CLPlacemark
                self.displayLocationInfo(pe)
            }else{
                println("Error with Data")
            }
        })
    }

    func displayLocationInfo(placemark: CLPlacemark){
        self.locationManager.stopUpdatingLocation()
        println(placemark.locality)
        println(placemark.postalCode)
        println(placemark.country)
    }
    
    func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!) {
        println("Error:"+error.localizedDescription)
    }

}

