import Foundation

enum APIEndpoints {
    private static var baseURL: URL {
        guard let configuration = APIConfiguration.current else {
            fatalError("API Configuration not set. Call APIConfiguration.configure() before making any requests.")
        }
        return configuration.baseURL
            .appendingPathComponent(configuration.version)
    }
    
    case login
    case signup
    case refreshToken
    
    var path: String {
        switch self {
        case .login:
            return "/auth/login"
        case .signup:
            return "/auth/signup"
        case .refreshToken:
            return "/auth/refresh"
        }
    }
    
    var url: URL {
        Self.baseURL.appendingPathComponent(path)
    }
} 