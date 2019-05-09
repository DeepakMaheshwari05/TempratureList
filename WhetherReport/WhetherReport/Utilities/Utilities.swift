
import UIKit
import Foundation

class Utilities {
    
    
    class func getcityTempratureFromServer(_ id:String, CompletionBlockWithSuccess success: @escaping (_ responseObject: [String:Any]) -> Void)  {
        let headers = ["cache-control": "no-cache"]
        
        var request: NSMutableURLRequest? = nil
        let str = kGetWatherTempById + id + kAppIdpara + kAPIKey
        if let aString = URL(string: str) {
            request = NSMutableURLRequest(url: aString, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 60.0)
        }
        request?.httpMethod = "POST"
        request?.allHTTPHeaderFields = headers
        
        let session = URLSession.shared
        var dataTask: URLSessionDataTask? = nil
        if let aRequest = request {
            dataTask = session.dataTask(with: aRequest as URLRequest, completionHandler: { data, response, error in
                if error != nil {
                    if let anError = error {
                        print("\(anError)")
                    }
                } else {
                    let httpResponse = response as? HTTPURLResponse
                    if let aResponse = httpResponse {
                    //    print("\(aResponse)")
                        do {
                            let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [String:Any]
                             success(json)
                           
                        } catch let error as NSError {
                            print(error)
                        }
                    }
                }
            })
        }
        dataTask?.resume()
    }
    
    class func getcityDetailFromServer(_ id:String, CompletionBlockWithSuccess success: @escaping (_ responseObject: [String:Any]) -> Void)  {
        let headers = ["cache-control": "no-cache"]
        
        var request: NSMutableURLRequest? = nil
        let str = kGetWatherTempById + id + kAppIdpara + kAPIKey
        if let aString = URL(string: str) {
            request = NSMutableURLRequest(url: aString, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 60.0)
        }
        request?.httpMethod = "POST"
        request?.allHTTPHeaderFields = headers
        
        let session = URLSession.shared
        var dataTask: URLSessionDataTask? = nil
        if let aRequest = request {
            dataTask = session.dataTask(with: aRequest as URLRequest, completionHandler: { data, response, error in
                if error != nil {
                    if let anError = error {
                        print("\(anError)")
                    }
                } else {
                    let httpResponse = response as? HTTPURLResponse
                    if let aResponse = httpResponse {
                        print("\(aResponse)")
                        do {
                            let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [String:Any]
                            success(json)
                            
                        } catch let error as NSError {
                            print(error)
                        }
                    }
                }
            })
        }
        dataTask?.resume()
    }
    
}

extension UIView {
    func fadeTransition(_ duration:CFTimeInterval) {
        let animation = CATransition()
        animation.timingFunction = CAMediaTimingFunction(name:
            CAMediaTimingFunctionName.easeInEaseOut)
        animation.type = CATransitionType.moveIn
        animation.duration = duration
        layer.add(animation, forKey: CATransitionType.fade.rawValue)
    }
}
