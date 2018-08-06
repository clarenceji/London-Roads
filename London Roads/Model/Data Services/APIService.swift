//
//  APIService.swift
//  London Roads
//
//  Created by Clarence Ji on 8/5/18.
//  Copyright © 2018 Clarence Ji. All rights reserved.
//

import Foundation

enum APICallResult {
    case successful
    case failed(error: Error?)
}

class APIService {
    
    let session: URLSession
    let endpoint = "https://api.tfl.gov.uk/Road/"
    
    internal var appID = ""
    internal var developerKey = ""
    
    init(session: URLSession = .shared) {
        
        self.session = session
        
        guard
            let path = Bundle.main.path(forResource: "AppConfig", ofType: "plist"),
            let plistData = FileManager.default.contents(atPath: path)
        else { return }
        
        var format = PropertyListSerialization.PropertyListFormat.xml
        do {
            
            let dict = try PropertyListSerialization.propertyList(from: plistData, options: .mutableContainersAndLeaves, format: &format) as! [String: Any]
            self.appID = dict["TfLAppID"] as? String ?? ""
            self.developerKey = dict["TfLDeveloperKey"] as? String ?? ""
            
        } catch {
            fatalError("Cannot serialize property list (AppConfig.plist).")
        }
        
    }
    
    func statusUpdate(forRoadID road: String, completionHandler: @escaping (_ result: APICallResult, _ roadStatus: Road?) -> Void) {
        
        let urlString = endpoint + road + "?app_id=\(appID)&app_key=\(developerKey)"
        
        guard let url = URL(string: urlString) else {
            completionHandler(.failed(error: nil), nil)
            return
        }
        
        let task = session.dataTask(with: url) { (data, response, error) in
            
            guard let responseCode = (response as? HTTPURLResponse)?.statusCode else {
                // No response
                completionHandler(.failed(error: error), nil)
                return
            }
            
            if responseCode == 404 {
                // Road does not exist
                completionHandler(.successful, nil)
                return
            }
            
            guard responseCode == 200, data != nil else {
                // Other error occurred
                completionHandler(.failed(error: error), nil)
                return
            }
            
            let road = APIParser.parseRoadStatus(data: data!)
            
            completionHandler(.successful, road)
            return
            
        }
        
        task.resume()
        
    }
    
}
