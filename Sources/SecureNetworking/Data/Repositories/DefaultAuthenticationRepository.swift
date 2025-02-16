public final class DefaultAuthenticationRepository: AuthenticationRepository {
    private let networkService: NetworkingService
    
    public init(networkService: NetworkingService) {
        self.networkService = networkService
    }
    
    public func login(email: String, password: String) async throws -> AuthToken {
        let loginDTO = LoginRequestDTO(email: email, password: password)
        
        let request = try Request.json(
            url: APIEndpoints.login.url,
            method: .post,
            body: loginDTO
        )
        
        let responseDTO: AuthTokenDTO = try await networkService.request(request)
        return responseDTO.toDomain()
    }
    
    public func signup(email: String, password: String, name: String) async throws -> User {
        // Implementation similar to login
        fatalError("Not implemented")
    }
    
    public func refreshToken(_ token: String) async throws -> AuthToken {
        // Implementation for token refresh
        fatalError("Not implemented")
    }
} 