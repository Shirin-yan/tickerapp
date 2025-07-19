//
//  SearchVM.swift
//  tickerapp
//
//  Created by  Shirin-Yan on 19.07.2025.
//

final class SearchVM {
    
    private let fetchPopularSearchesUseCase: FetchPopularSearchesUseCase
    private let fetchRecentSearchesUseCase: FetchRecentSearchesUseCase
    private let fetchSearchResultsUseCase: FetchSearchResultsUseCase
    private let fetchLocalUseCase: FetchSavedTickersUseCase
    private let saveTickerUseCase: SaveTickerUseCase
    private let deleteTickerUseCase: DeleteTickerUseCase
    
    private(set) var searchResult: [Ticker] = []
    private(set) var localTickers: [Ticker] = []
    private(set) var recentSearches: [String] = []
    private(set) var popularSearches: [String] = []
    
    var onUpdateSearchOptions: (() -> Void)?
    var onUpdateTickers: (() -> Void)?
    var onError: ((any Error) -> Void)?
    
    init(fetchPopularSearchesUseCase: FetchPopularSearchesUseCase,
         fetchRecentSearchesUseCase: FetchRecentSearchesUseCase,
         fetchSearchResultsUseCase: FetchSearchResultsUseCase,
         fetchLocalUseCase: FetchSavedTickersUseCase,
         saveTickerUseCase: SaveTickerUseCase,
         deleteTickerUseCase: DeleteTickerUseCase) {
        self.fetchPopularSearchesUseCase = fetchPopularSearchesUseCase
        self.fetchRecentSearchesUseCase = fetchRecentSearchesUseCase
        self.fetchSearchResultsUseCase = fetchSearchResultsUseCase
        self.fetchLocalUseCase = fetchLocalUseCase
        self.saveTickerUseCase = saveTickerUseCase
        self.deleteTickerUseCase = deleteTickerUseCase
    }
    
    func loadSearchOptions() {
        Task {
            await fetchSearchOptions()
            fetchLocalTickers()
        }
    }
    
    func loadSearchResults(_ keyword: String) {
        Task {
            await fetchSearchResults(keyword)
            recentSearches = fetchRecentSearchesUseCase.execute()
        }
    }
    
    private func fetchLocalTickers() {
        do {
            self.localTickers = try fetchLocalUseCase.execute()
        } catch {
            self.onError?(error)
        }
    }

    private func fetchSearchOptions() async {
        do {
            recentSearches = fetchRecentSearchesUseCase.execute()
            popularSearches = try await fetchPopularSearchesUseCase.execute()
            self.onUpdateSearchOptions?()
        } catch {
            self.onError?(error)
        }
    }
    
    private func fetchSearchResults(_ keyword: String) async {
        do {
            searchResult = try await fetchSearchResultsUseCase.execute(keyword)
            self.onUpdateTickers?()
        } catch {
            self.onError?(error)
        }
    }
    
    func saveTicker(_ ticker: Ticker) {
        do {
            let success = try saveTickerUseCase.execute(ticker: ticker)
            if success {
                fetchLocalTickers()
                onUpdateTickers?()
            }
        } catch {
            onError?(error)
        }
    }

    func deleteTicker(_ ticker: Ticker) {
        do {
            let success = try deleteTickerUseCase.execute(ticker: ticker)
            if success {
                fetchLocalTickers()
                onUpdateTickers?()
            }
        } catch {
            onError?(error)
        }
    }

    func isSavedTicker(_ ticker: Ticker) -> Bool {
        return localTickers.contains(where: {
            $0.change.isEqual(to: ticker.change)
            && $0.symbol.isEqual(ticker.symbol)
            && $0.price.isEqual(to: ticker.price)
        })
    }
}
