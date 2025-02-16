public struct LoginUseCase {
    private let repository: AuthenticationRepository
    
    public init(repository: AuthenticationRepository) {
        self.repository = repository
    }
    
    public func execute(email: String, password: String) async throws -> AuthToken {
        try await repository.login(email: email, password: password)
    }
} 