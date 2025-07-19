//
//  RemoteTickerRepo.swift
//  tickerapp
//
//  Created by  Shirin-Yan on 19.07.2025.
//

protocol RemoteTickerRepo {
    func fetchTickers() async throws -> [Ticker]
}
