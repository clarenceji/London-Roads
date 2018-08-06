//
//  APIParser.swift
//  London Roads
//
//  Created by Clarence Ji on 8/5/18.
//  Copyright © 2018 Clarence Ji. All rights reserved.
//

import Foundation

class APIParser {
    
    private init() {}
    
    class func parseRoadStatus(data: Data) -> Road? {
        
        do {
            
            let dict = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [[String: Any]] ?? []
            guard let road = dict.first else { return nil }
            
            return Road(
                id: road["id"] as? String ?? "",
                name: road["displayName"] as? String ?? "",
                severity: road["statusSeverity"] as? String ?? "",
                severityDescription: road["statusSeverityDescription"] as? String ?? ""
            )
            
        } catch {
            fatalError("Cannot serialize JSON object with data (parseRoadStatus).")
        }
        
    }
    
}
