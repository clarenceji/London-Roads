//
//  MockURLSession.swift
//  London RoadsTests
//
//  Created by Clarence Ji on 8/5/18.
//  Copyright © 2018 Clarence Ji. All rights reserved.
//

import Foundation

class MockURLSession: URLSession {
    
    var data: Data?
    var urlResponse: URLResponse?
    var error: Error?
    
    override func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        
        return MockURLSessionDataTask(closure: {
            completionHandler(self.data, self.urlResponse, self.error)
        })
        
    }
    
}
