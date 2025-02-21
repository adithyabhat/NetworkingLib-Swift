public enum NetworkingImplementation {
    case urlSession
    case alamofire
    case mock(shouldSimulateError: Bool = false, responseDelay: TimeInterval = 1.0)
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
            fatalError("Alamofire implementation not yet available")
        case .mock(let shouldSimulateError, let responseDelay):
            return MockNetworkService(
                shouldSimulateError: shouldSimulateError,
                responseDelay: responseDelay
            )
        case .custom(let service):
            return service
        }
    }
} 