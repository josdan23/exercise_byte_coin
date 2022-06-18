//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation

protocol CoinManagerDelegate {
    func didFailWithError(error: Error)
    func didUpdateCoin( coin: CoinData)
}

struct CoinManager {
    
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let apiKey = "8001FC1B-7E97-43D2-8236-574BABE91A51"
    
    var delegate: CoinManagerDelegate?
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]

    func getCoinPrice(for currency: String) {
        let urlString  = "\(baseURL)/\(currency)?apikey=\(apiKey)"
        performRequest(urlString: urlString)
    }
    
    func performRequest(urlString: String) {
        
        if let url = URL(string: urlString) {
            
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url) { data, response, error in
                
                if let secureData = data {
                    if let data = parseJSON(data: secureData) {
                        delegate?.didUpdateCoin(coin: data)
                    }
                   
                }
                
            }
            
            task.resume()
        }
    }
    
    func parseJSON(data: Data) -> CoinData? {
        
        let decoder = JSONDecoder()
        
        do {
            let coinData = try decoder.decode(CoinData.self, from: data)
            return coinData
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
        
    }
}
