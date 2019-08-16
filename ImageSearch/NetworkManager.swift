//
//  NetworkManager.swift
//  ImageSearch
//
//  Created by Mobile Team 3 on 12/12/17.
//  Copyright © 2017 Mobile Team 3. All rights reserved.
//

import UIKit

class NetworkManager: NSObject {
    var urlSession:URLSession?
    
    let  endPoint = "https://api.flickr.com/services/rest/"
    
    override init() {
        let defaultConfiguration = URLSessionConfiguration.default
        urlSession = URLSession(configuration: defaultConfiguration)
    }
    
    func getImages(searchTerm:String, completion : @escaping (_ flickr : Flickr?)->Void){
//        var urlComponents = URLComponents(string: endPoint)
//            urlComponents?.query = "method=flickr.photos.search&api_key=f2e92bdade8c1afb7dc1005c2272d89d&extras=url_s&format=json&nojsoncallback=1&text=\(searchTerm)"
        let url = endPoint + "?method=flickr.photos.search&api_key=f2e92bdade8c1afb7dc1005c2272d89d&extras=url_s&format=json&nojsoncallback=1&text=\(searchTerm)"
//        guard let url = urlComponents?.url else { return }
        let urlURL = URL(string  : url)
        let dataTask = urlSession?.dataTask(with: urlURL!, completionHandler: {(data,response,error) in
            let jsonString = String(data : data!, encoding : String.Encoding.utf8)
            print("\(jsonString!)")
            let res = response as! HTTPURLResponse
            print(res.statusCode)
            let jsonDecoder = JSONDecoder()
            do{
                let flickr =  try jsonDecoder.decode(Flickr.self, from: data!)
                print(flickr)
                completion(flickr)
            }
            catch{ print("\(error)")}
            
            
        })
        dataTask?.resume()
        
        
    }
    
    
    
    // MARK: function to download contact profile image asynchronously.
//    func downloadImageFrom(link: String, contentMode: UIViewContentMode) {
//        if link != "" {
//            URLSession.shared.dataTask( with: NSURL(string: link)! as URL, completionHandler: { (data, _, _) -> Void in
//                DispatchQueue.main.async {
//                    self.contentMode =  contentMode
//                    if let data = data { self.image = UIImage(data: data) }
//                }
//            }).resume()
//        }
//    }

}
