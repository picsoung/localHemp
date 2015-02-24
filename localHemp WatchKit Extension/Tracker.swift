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