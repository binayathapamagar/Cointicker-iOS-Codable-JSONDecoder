//
//  ViewController.swift
//  CoinTicker
//
//  Created by Binaya on 30/05/2021.
//

import UIKit

class CoinTickerViewController: UIViewController {

    var coinManager = CoinManager()
    @IBOutlet weak var bitcoinLabel: UIImageView!
    @IBOutlet weak var bitcoinPriceLabel: UILabel!
    @IBOutlet weak var ethereumPriceLabel: UILabel!
    @IBOutlet weak var litecoinPriceLabel: UILabel!
    @IBOutlet weak var bitcoinCurrencyLabel: UILabel!
    @IBOutlet weak var ethereumCurrencyLabel: UILabel!
    @IBOutlet weak var litecoinCurrencyLabel: UILabel!
    @IBOutlet weak var countryPicker: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        countryPicker.dataSource = self
        countryPicker.delegate = self
        coinManager.delegate = self
        coinManager.getRate(with: coinManager.currencyArray[0])
    }

}

//MARK: - UIPickerViewDelegate

extension CoinTickerViewController: UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        coinManager.currencyArray.count
    }
    
}

extension CoinTickerViewController: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return coinManager.currencyArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        coinManager.getRate(with: coinManager.currencyArray[row])
    }
    
}

extension CoinTickerViewController: CoinManagerDelegate {
    
    func didGetCoinData(_ coinManager: CoinManager, _ coinModel: CoinModel) {
        DispatchQueue.main.async {
            if coinModel.coinType == "BTC" {
                self.bitcoinPriceLabel.text = coinModel.rateIn2DP
                self.bitcoinCurrencyLabel.text = coinModel.countryCode
            }else if coinModel.coinType == "ETH" {
                self.ethereumPriceLabel.text = coinModel.rateIn2DP
                self.ethereumCurrencyLabel.text = coinModel.countryCode
            }else {
                self.litecoinPriceLabel.text = coinModel.rateIn2DP
                self.litecoinCurrencyLabel.text = coinModel.countryCode
            }
        }
    }
    
    func didFailWithError(_ error: Error) {
        print(error.localizedDescription)
    }
    
}
