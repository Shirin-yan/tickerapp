//
//  DI.swift
//  tickerapp
//
//  Created by  Shirin-Yan on 19.07.2025.
//

final class AppDIContainer {
    static let shared = AppDIContainer()

    private init() {}

    lazy var remoteRepo: RemoteTickerRepo = RemoteTickerRepoImpl()
    lazy var localRepo: LocalTickerRepo = LocalTickerRepoImpl()
    lazy var searchRepo: SearchRepo = SearchRepoImpl()

    lazy var fetchRemoteUseCase = FetchRemoteTickersUseCase(repo: remoteRepo)
    lazy var fetchLocalUseCase = FetchSavedTickersUseCase(repo: localRepo)
    lazy var saveTickerUseCase = SaveTickerUseCase(repo: localRepo)
    lazy var deleteTickerUseCase = DeleteTickerUseCase(repo: localRepo)
    lazy var fetchPopularSearchesUseCase = FetchPopularSearchesUseCase(repo: searchRepo)
    lazy var fetchRecentSearchesUseCase = FetchRecentSearchesUseCase(repo: searchRepo)
    lazy var fetchSearchResultsUseCase = FetchSearchResultsUseCase(repo: searchRepo)

    func makeTickerListViewModel() -> TickerListVM {
        TickerListVM(
            fetchRemoteUseCase: fetchRemoteUseCase,
            fetchLocalUseCase: fetchLocalUseCase,
            saveTickerUseCase: saveTickerUseCase,
            deleteTickerUseCase: deleteTickerUseCase
        )
    }
    
    func makeSearchViewModel() -> SearchVM {
        SearchVM(fetchPopularSearchesUseCase: fetchPopularSearchesUseCase,
                 fetchRecentSearchesUseCase: fetchRecentSearchesUseCase,
                 fetchSearchResultsUseCase: fetchSearchResultsUseCase,
                 fetchLocalUseCase: fetchLocalUseCase,
                 saveTickerUseCase: saveTickerUseCase,
                 deleteTickerUseCase: deleteTickerUseCase)
    }
}
