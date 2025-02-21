public final class DefaultAuthenticationRepository: AuthenticationRepository {
    private let networkService: NetworkingService
    private let requestBuilder: RequestBuilder
    
    public init(
        networkService: NetworkingService,
        requestBuilder: RequestBuilder
    ) {
        self.networkService = networkService
        self.requestBuilder = requestBuilder
    }
    
    public func login(email: String, password: String) async throws -> AuthToken {
        let loginDTO = LoginRequestDTO(email: email, password: password)
        let request = try Request.json(
            url: try requestBuilder.buildRequest(for: AuthEndpoints.login).url,
            method: .post,
            body: loginDTO
        )
        
        let responseDTO: AuthTokenDTO = try await networkService.request(request)
        return responseDTO.toDomain()
    }
    
    public func signup(email: String, password: String, name: String) async throws -> User {
        let signupDTO = SignupRequestDTO(email: email, password: password, name: name)
        let request = try Request.json(
            url: try requestBuilder.buildRequest(for: AuthEndpoints.signup).url,
            method: .post,
            body: signupDTO
        )
        
        let responseDTO: UserDTO = try await networkService.request(request)
        return responseDTO.toDomain()
    }
    
    public func refreshToken(_ token: String) async throws -> AuthToken {
        let request = try requestBuilder.buildRequest(for: AuthEndpoints.refreshToken)
        let responseDTO: AuthTokenDTO = try await networkService.request(request)
        return responseDTO.toDomain()
    }
} 