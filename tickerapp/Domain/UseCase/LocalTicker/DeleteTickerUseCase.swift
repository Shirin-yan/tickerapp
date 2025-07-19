//
//  DeleteTickerUseCase.swift
//  tickerapp
//
//  Created by  Shirin-Yan on 19.07.2025.
//

class DeleteTickerUseCase {
    private let repo: LocalTickerRepo

    init(repo: LocalTickerRepo) {
        self.repo = repo
    }

    func execute(ticker: Ticker) throws -> Bool {
        return try repo.deleteTicker(ticker)
    }
}
