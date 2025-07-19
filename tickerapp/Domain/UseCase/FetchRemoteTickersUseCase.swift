//
//  FetchRemoteTickersUseCase.swift
//  tickerapp
//
//  Created by  Shirin-Yan on 19.07.2025.
//

class FetchRemoteTickersUseCase {
    private let repo: RemoteTickerRepo

    init(repo: RemoteTickerRepo) {
        self.repo = repo
    }

    func execute() async throws -> [Ticker] {
        return try await repo.fetchTickers()
    }
}
