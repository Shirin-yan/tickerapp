//
//  FetchSavedTickersUseCase.swift
//  tickerapp
//
//  Created by  Shirin-Yan on 19.07.2025.
//

class FetchSavedTickersUseCase {
    private let repo: LocalTickerRepo

    init(repo: LocalTickerRepo) {
        self.repo = repo
    }

    func execute() throws -> [Ticker] {
        return try repo.fetchSavedTickers()
    }
}
