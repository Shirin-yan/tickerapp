//
//  RemoteTickerRepoImpl.swift
//  tickerapp
//
//  Created by  Shirin-Yan on 19.07.2025.
//

class RemoteTickerRepoImpl: RemoteTickerRepo {
    
    func fetchTickers() async throws -> [Ticker] {
        return try await Network.request(endpoint: .tickers)
    }
}
