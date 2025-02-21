import Foundation

public enum NetworkEnvironment {
    case development
    case staging
    case production
    case custom(String)
    
    var value: String {
        switch self {
        case .development:
            return "development"
        case .staging:
            return "staging"
        case .production:
            return "production"
        case .custom(let value):
            return value
        }
    }
} 