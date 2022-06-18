//
//  CoinData.swift
//  ByteCoin
//
//  Created by Daniel Yapura on 17/06/2022.
//  Copyright © 2022 The App Brewery. All rights reserved.
//

import Foundation

struct CoinData : Decodable {
    let rate: Double
    let asset_id_quote: String
}
