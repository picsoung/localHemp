
//
//  ListViewController.swift
//  localHemp
//
//  Created by Nicolas Grenie on 2/24/15.
//  Copyright (c) 2015 Nicolas Grenie. All rights reserved.
//

import Foundation
import UIKit

class CustomTableViewCell : UITableViewCell {
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet weak var ratingImage: UIImageView!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    func loadItem(#title: String, ratingImageURL: String,ratingValue:Double,distanceText:String,timeText:String) {
        println("URL",ratingImageURL)
        let ratingImageURL = ratingImageURL.stringByReplacingOccurrencesOfString("/240?", withString: "/100?", options: nil, range: nil) //change size to 50px width
        let url = NSURL(string: ratingImageURL)
        let data = NSData(contentsOfURL: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check
        ratingImage.image = UIImage(data: data!)
        titleLabel.text = title
        ratingLabel.text = String(stringInterpolationSegment: ratingValue)
        distanceLabel.text = distanceText
        timeLabel.text = timeText
    }

}

class ListViewController: UIViewController,UITableViewDataSource, UITableViewDelegate{
    
    @IBOutlet weak var shopListTableView: UITableView!
    var tableData = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var nib = UINib(nibName: "CustomTableViewCell", bundle: nil)
        shopListTableView.registerNib(nib, forCellReuseIdentifier: "customCell")
        getLeaflyJSON("https://0337e9ab-d575fbfbad2f.my.apitools.com/locations")
    }
    
    
    func getLeaflyJSON(apiURL : String){
        let mySession = NSURLSession.sharedSession()
        let url: NSURL = NSURL(string: apiURL)!
        
        let request = NSMutableURLRequest(URL: url)
        request.HTTPMethod = "POST"
        let postString = "page=0&take=10&latitude=41.398553&longitude=2.175034"
        request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding)
        request.setValue("c90569b3", forHTTPHeaderField: "app_id")
        request.setValue("9acba542d827c5349d05df691109af05", forHTTPHeaderField: "app_key")
        
        let networkTask = mySession.dataTaskWithRequest(request, completionHandler : {data, response, error -> Void in
            var err: NSError?
            var theJSON = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: &err) as! NSDictionary
            
            if let element: AnyObject = theJSON["stores"] {
                let results : NSArray = element as! NSArray
                dispatch_async(dispatch_get_main_queue(), {
                    self.tableData = results
                    self.shopListTableView!.reloadData()
                })
            }
        })
        networkTask.resume()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func calculateDistance(lat: Double, long: Double) -> Double{
            let pi = 3.14159
            let radius = 3958.75587
    
            let rlat = lat * pi/180
            let rlng = long * pi/180
            let rlat2 = 41.398553 * pi/180
            let rlng2 = 2.175034 * pi/180
    
            if (rlat == rlat2 && rlng == rlng2){
              return 0
            }
            else{
                //Spherical Law of Cosines
                return radius*acos(sin(rlat)*sin(rlat2)+cos(rlng-rlng2)*cos(rlat)*cos(rlat2))
            }
    }
    
    func sortByDistance(){
    
    }
    
    // Change cellsize
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 100;
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell:CustomTableViewCell = self.shopListTableView.dequeueReusableCellWithIdentifier("customCell") as! CustomTableViewCell
        
        let shopEntry : NSMutableDictionary = self.tableData[indexPath.row] as! NSMutableDictionary
        
        println(shopEntry["distance"]!["time"])
        cell.loadItem(title: shopEntry["name"] as! String, ratingImageURL: shopEntry["starImage"] as! String,ratingValue: shopEntry["rating"] as! Double, distanceText: shopEntry["distance"]!["walkingDistanceText"] as! String, timeText: shopEntry["distance"]!["time"] as! String)
        
        return cell
    }
}
