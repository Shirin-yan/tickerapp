//
//  NumberFormatter.swift
//  tickerapp
//
//  Created by  Shirin-Yan on 19.07.2025.
//

import Foundation

extension NumberFormatter {
    static let priceFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.maximumFractionDigits = 0
        formatter.currencySymbol = "$"
        return formatter
    }()
}
