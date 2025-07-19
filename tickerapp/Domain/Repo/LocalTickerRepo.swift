//
//  LocalTickerRepo.swift
//  tickerapp
//
//  Created by  Shirin-Yan on 19.07.2025.
//

import Foundation

protocol LocalTickerRepo {
    func fetchSavedTickers() throws -> [Ticker]
    func saveTicker(_ ticker: Ticker) throws -> Bool
    func deleteTicker(_ ticker: Ticker) throws -> Bool
}
