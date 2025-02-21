import Foundation

public final class MockAuthenticationRepository: AuthenticationRepository {
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
    
    public func login(email: String, password: String) async throws -> AuthToken {
        try await simulateNetworkDelay()
        
        if shouldSimulateError {
            throw MockError.simulatedError
        }
        
        return AuthToken(
            accessToken: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
            refreshToken: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
            expiresIn: 3600
        )
    }
    
    public func signup(email: String, password: String, name: String) async throws -> User {
        try await simulateNetworkDelay()
        
        if shouldSimulateError {
            throw MockError.simulatedError
        }
        
        return User(
            id: "12345",
            email: email,
            name: name
        )
    }
    
    public func refreshToken(_ token: String) async throws -> AuthToken {
        try await simulateNetworkDelay()
        
        if shouldSimulateError {
            throw MockError.simulatedError
        }
        
        return AuthToken(
            accessToken: "new_access_token...",
            refreshToken: "new_refresh_token...",
            expiresIn: 3600
        )
    }
    
    private func simulateNetworkDelay() async throws {
        try await Task.sleep(nanoseconds: UInt64(responseDelay * 1_000_000_000))
    }
} 