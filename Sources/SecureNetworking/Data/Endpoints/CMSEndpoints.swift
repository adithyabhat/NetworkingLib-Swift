import Foundation

enum CMSEndpoints: NetworkEndpoint {
    case content(id: String)
    case media(path: String)
    
    var path: String {
        switch self {
        case .content(let id):
            return "/content/\(id)"
        case .media(let path):
            return "/media/\(path)"
        }
    }
    
    var method: HTTPMethod { .get }
    var backendType: BackendType { .sitecore }
} 