//
//  CoinModel.swift
//  CoinTicker
//
//  Created by Binaya on 30/05/2021.
//

import Foundation

struct CoinModel {
    var coinType: String
    var countryCode: String
    var rate: Double
    var rateIn2DP: String {
        return String(format: "%0.2f", rate)
    }
    static let coins = ["BTC", "ETH", "LTC"]
}
