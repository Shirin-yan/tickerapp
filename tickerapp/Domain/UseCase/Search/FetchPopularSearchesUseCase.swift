//
//  FetchPopularSearchesUseCase.swift
//  tickerapp
//
//  Created by  Shirin-Yan on 19.07.2025.
//

class FetchPopularSearchesUseCase {
    private let repo: SearchRepo

    init(repo: SearchRepo) {
        self.repo = repo
    }

    func execute() async throws -> [String] {
        return try await repo.fetchPopularSearches()
    }
}
