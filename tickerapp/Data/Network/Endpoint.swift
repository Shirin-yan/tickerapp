//
//  Endpoint.swift
//  tickerapp
//
//  Created by  Shirin-Yan on 19.07.2025.
//

import Foundation

enum Endpoint {
    case tickers
    case search(keywrd: String)
    
    var url: URL {
        switch self {
        case .tickers:
            return URL(string: "https://mustdev.ru/api/stocks.json")!
        case .search:
            return URL(string: "https://mustdev.ru/api/stocks.json")!
        }
    }
    
    var method: String {
        let method: HTTPMethod
        
        switch self {
        case .tickers:
            method = .get
        case .search:
            method = .get
        }
        
        return method.rawValue
    }

    var body: [String: Any]? {
        switch self {
        case .tickers:
            return nil
        case .search:
            return nil
        }
    }
    
    var headers: [String: String]? {
        return [
            "Content-Type": "application/json"
            // Add Authorization here if needed
        ]
    }
}


extension Endpoint {
    private enum HTTPMethod: String {
        case get = "GET"
        case post = "POST"
        case put = "PUT"
        case delete = "DELETE"
    }
}


