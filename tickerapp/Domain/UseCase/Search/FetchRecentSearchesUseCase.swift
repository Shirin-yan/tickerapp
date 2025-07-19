//
//  FetchRecentSearchesUseCase.swift
//  tickerapp
//
//  Created by  Shirin-Yan on 19.07.2025.
//

class FetchRecentSearchesUseCase {
    private let repo: SearchRepo

    init(repo: SearchRepo) {
        self.repo = repo
    }

    func execute() -> [String] {
        return repo.fetchRecentSearches()
    }
}
