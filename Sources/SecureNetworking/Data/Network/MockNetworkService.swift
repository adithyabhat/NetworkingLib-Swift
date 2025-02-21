import Foundation

public final class MockNetworkService: NetworkingService {
    public enum MockError: Error {
        case simulatedError
    }
    
    private let shouldSimulateError: Bool
    private let responseDelay: TimeInterval
    
    public init(
        shouldSimulateError: Bool = false,
        responseDelay: TimeInterval = 1.0
    ) {
        self.shouldSimulateError = shouldSimulateError
        self.responseDelay = responseDelay
    }
    
    public func request<T: Decodable>(_ request: Request) async throws -> T {
        try await simulateNetworkDelay()
        
        if shouldSimulateError {
            throw MockError.simulatedError
        }
        
        let mockData = getMockResponse(for: request)
        return try JSONDecoder().decode(T.self, from: mockData)
    }
    
    public func request(_ request: Request) async throws -> Data {
        try await simulateNetworkDelay()
        
        if shouldSimulateError {
            throw MockError.simulatedError
        }
        
        return getMockResponse(for: request)
    }
    
    public func streamData(for request: Request) -> AsyncStream<Data> {
        AsyncStream { continuation in
            Task {
                do {
                    try await simulateNetworkDelay()
                    let data = getMockResponse(for: request)
                    continuation.yield(data)
                    continuation.finish()
                } catch {
                    continuation.finish()
                }
            }
        }
    }
    
    public func request<T>(_ request: Request, withTimeout timeout: TimeInterval?) async throws -> T where T : Decodable {
        try await request(request)
    }
    
    private func getMockResponse(for request: Request) -> Data {
        // Return different mock responses based on the endpoint
        if request.url.absoluteString.contains("/auth/login") {
            return MockResponses.jsonData(from: MockResponses.loginSuccess)
        } else if request.url.absoluteString.contains("/auth/signup") {
            return MockResponses.jsonData(from: MockResponses.userProfile)
        }
        
        return Data()
    }
    
    private func simulateNetworkDelay() async throws {
        try await Task.sleep(nanoseconds: UInt64(responseDelay * 1_000_000_000))
    }
} 