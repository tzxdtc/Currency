//
//  Constants.swift
//  Currency
//
//  Created by 小牛 on 2020/08/30.
//  Copyright © 2020 小牛. All rights reserved.
//

import Foundation
struct Constants {
    static let usd = "USD"
    static let timer = 1800
    
    struct Cell {
        static let cellIdentifier = "CurrencyCell"
        static let cellNibName = "CurrencyCell"
        static let space = 10.0
    }
    
    struct API {
        static let url = "http://apilayer.net/api/live"
        static let accessKey = "a9cafb950f5142c3b84aa9473626dc2c"
    }
    
    struct ErrorMessage {
        static let title = "Opps"
        static let message = "An error has occurred..."
        static let actionTitle = "OK"
    }
    
    
}
