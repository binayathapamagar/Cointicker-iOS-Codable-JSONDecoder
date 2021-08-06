//
//  CoinManager.swift
//  CoinTicker
//
//  Created by Binaya on 30/05/2021.
//

import Foundation

protocol CoinManagerDelegate {
    func didGetCoinData(_ coinManager: CoinManager, _ coinModel: CoinModel)
    func didFailWithError(_ error: Error)
}

struct CoinManager {
    
    var delegate: CoinManagerDelegate?
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    let apiKey = ""
    
    func getRate(with countryCode: String) {
        
        for coinType in CoinModel.coins {
            let url = "https://rest.coinapi.io/v1/exchangerate/\(coinType)/\(countryCode)?apikey=\(apiKey)"
            performRequest(with: url)
        }
        
    }
    
    func performRequest(with urlString: String) {
        
        if let url = URL(string: urlString) {
            
            let urlSession = URLSession(configuration: .default)
            let task = urlSession.dataTask(with: url) { data, response, error in
                if let e = error {
                    delegate?.didFailWithError(e)
                    return
                }
                if let validData = data {
                    if let parsedCoinData = parseJSON(from: validData) {
                        delegate?.didGetCoinData(self, parsedCoinData)
                    }
                }
            }
            task.resume()
            
        }
        
    }
    
    func parseJSON (from data: Data) -> CoinModel?{
        
        let decoder = JSONDecoder()
        do {
            let coinData = try decoder.decode(CoinData.self, from: data)
            return CoinModel(coinType: coinData.asset_id_base, countryCode: coinData.asset_id_quote, rate: coinData.rate)
        }catch {
            delegate?.didFailWithError(error)
            return nil
        }
        
    }
    
}

extension CoinManagerDelegate {
    func didGetCoinData(_ coinManager: CoinManager, _ coinModel: CoinModel) {}
    func didFailWithError(_ error: Error){}
}
