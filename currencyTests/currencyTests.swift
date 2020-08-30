//
//  CurrencyTests.swift
//  CurrencyTests
//
//  Created by 小牛 on 2020/08/29.
//  Copyright © 2020 小牛. All rights reserved.
//

import XCTest
@testable import Currency

class CurrencyTests: XCTestCase {
    
    func testCalculateCurrency() throws {
        let inputMoney = "100"
        let selfCurrencyValue = 10.0 as Float
        let objectCurrencyValue = [5.0,5.0] as [Float]
        let indexPathRow = 1
        let viewController = ViewController()
        XCTAssertEqual(viewController.calculateCurrency(inputMoney: inputMoney, selfCurrencyValue: selfCurrencyValue, objectCurrencyValue: objectCurrencyValue, indexPathRow: indexPathRow), "50.0")
    }
    
    func testFetchData() throws{
        let viewController = ViewController()
        EasyRequest<CurrencyInfo>.get(viewController, url: "\(Constants.API.url)?access_key=\(Constants.API.accessKey)") { (results) in
            XCTAssertNotNil(results.quotes)
        }
    }
}
