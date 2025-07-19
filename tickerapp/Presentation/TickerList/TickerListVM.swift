//
//  TickerListVM.swift
//  tickerapp
//
//  Created by  Shirin-Yan on 19.07.2025.
//

import Foundation

final class TickerListVM {
    
    private let fetchRemoteUseCase: FetchRemoteTickersUseCase
    private let fetchLocalUseCase: FetchSavedTickersUseCase
    private let saveTickerUseCase: SaveTickerUseCase
    private let deleteTickerUseCase: DeleteTickerUseCase
    
    private(set) var remoteTickers: [Ticker] = []
    private(set) var localTickers: [Ticker] = []
    
    var onUpdate: (() -> Void)?
    var onError: ((any Error) -> Void)?
    
    init(fetchRemoteUseCase: FetchRemoteTickersUseCase,
         fetchLocalUseCase: FetchSavedTickersUseCase,
         saveTickerUseCase: SaveTickerUseCase,
         deleteTickerUseCase: DeleteTickerUseCase ) {
        self.fetchRemoteUseCase = fetchRemoteUseCase
        self.fetchLocalUseCase = fetchLocalUseCase
        self.saveTickerUseCase = saveTickerUseCase
        self.deleteTickerUseCase = deleteTickerUseCase
    }
    
    func loadTickers() {
        Task {
            fetchLocal()
            await fetchRemote()
        }
    }
    
    func fetchRemote() async {
        do {
            let tickers = try await fetchRemoteUseCase.execute()
            self.remoteTickers = tickers+tickers
            self.onUpdate?()
        } catch {
            self.onError?(error)
        }
    }
    
    func fetchLocal() {
        do {
            let tickers = try fetchLocalUseCase.execute()
            self.localTickers = tickers
            self.onUpdate?()
        } catch {
            self.onError?(error)
        }
    }
    
    func saveTicker(_ ticker: Ticker) {
        do {
            let success = try saveTickerUseCase.execute(ticker: ticker)
            if success {
                fetchLocal()
            }
        } catch {
            onError?(error)
        }
    }

    func deleteTicker(_ ticker: Ticker) {
        do {
            let success = try deleteTickerUseCase.execute(ticker: ticker)
            if success {
                fetchLocal()
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
