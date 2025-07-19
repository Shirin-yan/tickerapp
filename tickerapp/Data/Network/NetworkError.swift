//
//  NetworkError.swift
//  tickerapp
//
//  Created by  Shirin-Yan on 19.07.2025.
//

enum NetworkError: Error {
    case invalidResponse
    case badStatusCode(Int)
    case decodingError(Error)
    case custom(String)
    
    var localizedDescription: String {
        switch self {
        case .invalidResponse:
            return "Invalid response"
        case .badStatusCode(let code):
            return "Bad status code: \(code)"
        case .decodingError:
            return "Decoding error"
        case .custom(let message):
            return message
        }
    }
}
