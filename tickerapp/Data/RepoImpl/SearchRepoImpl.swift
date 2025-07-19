//
//  RemoteTickerRepoImpl.swift
//  tickerapp
//
//  Created by  Shirin-Yan on 19.07.2025.
//

import Foundation

class SearchRepoImpl: SearchRepo {
    
    private let userDefault = UserDefaults.standard
    private let recentSearchesKey = "recent_searches"
    
    func fetchSearchResults(keyword: String) async throws -> [Ticker] {
        saveRecentSearch(keyword)
        do {
            let result: [Ticker] = try await Network.request(endpoint: .search(keywrd: keyword))
            
            return result.filter {
                $0.symbol.lowercased().contains(keyword.lowercased())
                || $0.name.contains(keyword.lowercased())
                || "\($0.price)".contains(keyword.lowercased())
            }
        } catch {
            throw error
        }
    }
    
    func fetchRecentSearches() -> [String] {
        return userDefault.array(forKey: recentSearchesKey) as? [String] ?? []
    }
    
    func fetchPopularSearches() async throws -> [String] {
        return ["GOOGL", "AAPL", "MSFT", "AMZN"].shuffled()
    }
    
    func saveRecentSearch(_ keyword: String) {
        var searches = fetchRecentSearches()
        searches.removeAll(where: {$0 == keyword.uppercased()})
        searches.insert(keyword.uppercased(), at: 0)
        userDefault.set(Array(searches.prefix(5)), forKey: recentSearchesKey)
    }
}
