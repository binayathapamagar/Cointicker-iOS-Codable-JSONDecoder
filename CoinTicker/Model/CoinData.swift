//
//  CoinData.swift
//  CoinTicker
//
//  Created by Binaya on 30/05/2021.
//

import Foundation

struct CoinData: Decodable{
    var asset_id_base: String
    var asset_id_quote: String
    var rate: Double
}
