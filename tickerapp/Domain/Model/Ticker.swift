//
//  Ticker.swift
//  tickerapp
//
//  Created by  Shirin-Yan on 19.07.2025.
//

struct Ticker: Codable {
    let symbol: String
    let name: String
    let price: Double
    let change: Double
    let changePercent: Double
    let logo: String
}
