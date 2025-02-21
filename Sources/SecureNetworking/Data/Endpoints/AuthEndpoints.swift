import Foundation

enum AuthEndpoints: NetworkEndpoint {
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
    
    var method: HTTPMethod {
        switch self {
        case .login, .signup:
            return .post
        case .refreshToken:
            return .put
        }
    }
    
    var backendType: BackendType { .backend }
} 