//
//  SearchUseCase.swift
//  tickerapp
//
//  Created by  Shirin-Yan on 19.07.2025.
//

class FetchSearchResultsUseCase {
    
    private let repo: SearchRepo

    init(repo: SearchRepo) {
        self.repo = repo
    }

    func execute(_ keyword: String) async throws -> [Ticker] {
        return try await repo.fetchSearchResults(keyword: keyword)
    }
}
