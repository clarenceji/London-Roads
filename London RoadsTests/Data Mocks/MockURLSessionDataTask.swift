//
//  MockURLSessionDataTask.swift
//  London RoadsTests
//
//  Created by Clarence Ji on 8/5/18.
//  Copyright © 2018 Clarence Ji. All rights reserved.
//

import Foundation

class MockURLSessionDataTask: URLSessionDataTask {
    
    private let closure: () -> Void
    
    init(closure: @escaping () -> Void) {
        self.closure = closure
    }
    
    override func resume() {
        closure()
    }
    
}
