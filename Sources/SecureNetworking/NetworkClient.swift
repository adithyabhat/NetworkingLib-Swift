import Foundation

public actor NetworkClient {
    private let service: NetworkingService
    
    public init(
        implementation: NetworkingImplementation = .urlSession,
        configuration: URLSessionConfiguration = .default,
        decoder: JSONDecoder = JSONDecoder()
    ) {
        self.service = NetworkingServiceFactory.create(
            implementation: implementation,
            configuration: configuration,
            decoder: decoder
        )
    }
    
    public func send<T: Decodable>(_ request: Request) async throws -> T {
        try await service.request(request)
    }
    
    public func send(_ request: Request) async throws -> Data {
        try await service.request(request)
    }
    
    public func streamData(
        for request: Request,
        delegate: URLSessionDataDelegate
    ) -> AsyncStream<Data> {
        service.streamData(for: request)
    }
    
    public func send<T: Decodable>(
        _ request: Request,
        withTimeout timeout: TimeInterval?
    ) async throws -> T {
        try await service.request(request, withTimeout: timeout)
    }
} 