import Foundation

public enum NetworkingImplementation {
    case urlSession
    case alamofire // For future use
    case custom(NetworkingService)
}

public final class NetworkingServiceFactory {
    public static func create(
        implementation: NetworkingImplementation = .urlSession,
        configuration: URLSessionConfiguration = .default,
        decoder: JSONDecoder = JSONDecoder()
    ) -> NetworkingService {
        switch implementation {
        case .urlSession:
            return URLSessionNetworkService(
                configuration: configuration,
                decoder: decoder
            )
        case .alamofire:
            // Future implementation
            fatalError("Alamofire implementation not yet available")
        case .custom(let service):
            return service
        }
    }
} 