//
//  London_RoadsUITests.swift
//  London RoadsUITests
//
//  Created by Clarence Ji on 8/5/18.
//  Copyright © 2018 Clarence Ji. All rights reserved.
//

import XCTest

class London_RoadsUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testHideKeyboardOnReturn() {
        
        let app = XCUIApplication()
        app.textFields["Road Number"].tap()
        app.textFields["Road Number"].typeText("A4")
        app.textFields["Road Number"].typeText("\n")
        
        let hasFocus = (app.textFields["Road Number"].value(forKey: "hasKeyboardFocus") as? Bool) ?? false
        
        XCTAssertEqual(hasFocus, false)
        
    }
    
    func testHideKeyboardOnTap() {
        
        let app = XCUIApplication()
        app.textFields["Road Number"].tap()
        app.textFields["Road Number"].typeText("A4")
        XCUIApplication().otherElements.containing(.navigationBar, identifier:"London Roads").children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.tap()
        
        
        let hasFocus = (app.textFields["Road Number"].value(forKey: "hasKeyboardFocus") as? Bool) ?? false
        
        XCTAssertEqual(hasFocus, false)
        
    }
    
    func testPerformSegueWithCorrectInput() {
        
        let app = XCUIApplication()
        app.textFields["Road Number"].tap()
        app.textFields["Road Number"].typeText("A4")
        app.textFields["Road Number"].typeText("\n")
        app.buttons["Get status"].tap()
        
        XCTAssert(app.staticTexts["Status"].exists)
        
    }
    
    func testPresentingAlertWithInvalidInput() {
        
        let app = XCUIApplication()
        app.textFields["Road Number"].tap()
        app.textFields["Road Number"].typeText("A1989")
        app.textFields["Road Number"].typeText("\n")
        app.buttons["Get status"].tap()
        
        sleep(3)
        
        XCTAssert(app.alerts["The road name you entered cannot be found."].exists)
        
    }
    
}
