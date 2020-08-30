//
//  CurrencyUITests.swift
//  CurrencyUITests
//
//  Created by 小牛 on 2020/08/29.
//  Copyright © 2020 小牛. All rights reserved.
//

import XCTest
@testable import Currency

class CurrencyUITests: XCTestCase {
    func testUI() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
        sleep(2)
        let textField = app.textFields["inputMoney"]
        if textField.exists {
            textField.tap()
            textField.typeText("1")
        }
        sleep(2)
        let labels = app.staticTexts.matching(identifier: "myLabel")
        if labels.count > 0{
            XCTAssertNotEqual(labels.element(boundBy: 0).label,"0")
        }
    }
}
