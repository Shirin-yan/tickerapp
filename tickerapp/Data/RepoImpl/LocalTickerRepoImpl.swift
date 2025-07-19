//
//  LocalTickerRepoImpl.swift
//  tickerapp
//
//  Created by  Shirin-Yan on 19.07.2025.
//

import Foundation

class LocalTickerRepoImpl: LocalTickerRepo {
    private let fileURL: URL

    init(filename: String = "saved_tickers.json") {
        let documents = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        self.fileURL = documents.appendingPathComponent(filename)
    }

    func fetchSavedTickers() throws -> [Ticker] {
        guard FileManager.default.fileExists(atPath: fileURL.path) else { return [] }
        let data = try Data(contentsOf: fileURL)
        return try JSONDecoder().decode([Ticker].self, from: data)
    }

    func saveTicker(_ ticker: Ticker) throws -> Bool {
        var savedTickers = try fetchSavedTickers()
        savedTickers.append(ticker)
        let data = try JSONEncoder().encode(savedTickers)
        try data.write(to: fileURL)
        return true
    }

    func deleteTicker(_ ticker: Ticker) throws -> Bool {
        var savedTickers = try fetchSavedTickers()
        savedTickers.removeAll { $0.symbol == ticker.symbol }
        let data = try JSONEncoder().encode(savedTickers)
        try data.write(to: fileURL)
        return true
    }
}
