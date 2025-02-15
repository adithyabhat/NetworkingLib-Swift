import Foundation

public enum NetworkError: LocalizedError {
    case invalidURL
    case noData
    case decodingFailed
    case invalidStatusCode(Int)
    case underlying(Error)
    case timeout
    
    public var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "The URL is invalid"
        case .noData:
            return "No data received from the server"
        case .decodingFailed:
            return "Failed to decode the response"
        case .invalidStatusCode(let code):
            return "Invalid status code: \(code)"
        case .underlying(let error):
            return error.localizedDescription
        case .timeout:
            return "The request timed out"
        }
    }
} 