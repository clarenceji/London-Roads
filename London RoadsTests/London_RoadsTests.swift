//
//  London_RoadsTests.swift
//  London RoadsTests
//
//  Created by Clarence Ji on 8/5/18.
//  Copyright © 2018 Clarence Ji. All rights reserved.
//

import XCTest
@testable import London_Roads

class London_RoadsTests: XCTestCase {
    
    private var apiService: APIService!
    private var session: MockURLSession!
    
    override func setUp() {
        
        super.setUp()

        self.session = MockURLSession()
        self.apiService = APIService(session: session)
        
    }
    
    override func tearDown() {
        session.data = nil
        session.urlResponse = nil
        session.error = nil
    }
    
    func testAPIServiceInitialization() {
        
        XCTAssertEqual(apiService.appID, "0612ac79")
        XCTAssertEqual(apiService.developerKey, "81ab22c7e2a33c17996e74e8851dfca8")
        
    }
    
    func testRoadParsing() {
        
        guard let jsonData = self.loadA2JSONData() else {
            XCTFail("Can't load A2.json")
            return
        }
        let road = APIParser.parseRoadStatus(data: jsonData)
            
        XCTAssertEqual(road?.id, "a2")
        XCTAssertEqual(road?.displayName, "A2")
        XCTAssertEqual(road?.statusSeverity, "Closure")
        XCTAssertEqual(road?.statusSeverityDescription, "Closure")
        
    }
    
    func testRoadDoesNotExistDataTask() {
        
        session.urlResponse = HTTPURLResponse(url: URL(string: "https://tfl.gov.uk")!, statusCode: 404, httpVersion: nil, headerFields: nil)
        
        apiService.statusUpdate(forRoadID: "A2") { (result, road) in
            
            switch result {
            case .successful:
                if road == nil { return }
                XCTFail()
                
            default:
                XCTFail()
            }
            
        }
        
    }
    
    func testRoadExistsFailedDataTask() {
        
        session.error = NSError(domain: "", code: -1009, userInfo: nil)
        
        apiService.statusUpdate(forRoadID: "A2") { (result, road) in
            
            switch result {
            case .failed(error: let error):
                if error?._code == -1009 && road == nil { return }
                XCTFail()
                
            default:
                XCTFail("")
            }
            
        }
        
    }
    
    func testRoadExistsSuccessfulDataTask() {
        
        let jsonData = loadA2JSONData()
        
        session.urlResponse = HTTPURLResponse(url: URL(string: "https://tfl.gov.uk")!, statusCode: 200, httpVersion: nil, headerFields: nil)
        session.data = jsonData
        
        apiService.statusUpdate(forRoadID: "A2") { (result, road) in
            
            switch result {
            case .successful:
                if road == nil { XCTFail("Road exists, the Road object should not be nil.") }
                return
                
            default:
                XCTFail("Road exists, but the result is \"failed\".")
            }
            
        }
        
    }
    
    private func loadA2JSONData() -> Data? {
        
        guard let url = Bundle(for: type(of: self)).url(forResource: "A2", withExtension: "json") else {
            fatalError("Cannot find file A2.json in bundle.")
        }
        
        do {
            let data = try Data(contentsOf: url, options: .mappedIfSafe)
            return data
        } catch {
            fatalError("A2.json cannot be converted to data object.")
        }
        
    }
    
}
