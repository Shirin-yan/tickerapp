//
//  SearchRepo.swift
//  tickerapp
//
//  Created by  Shirin-Yan on 19.07.2025.
//

protocol SearchRepo {
    func fetchPopularSearches() async throws -> [String]
    func fetchRecentSearches() -> [String]
    func fetchSearchResults(keyword: String) async throws -> [Ticker]
}
