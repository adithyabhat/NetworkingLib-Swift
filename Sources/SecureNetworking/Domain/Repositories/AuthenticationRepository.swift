public protocol AuthenticationRepository {
    func login(email: String, password: String) async throws -> AuthToken
    func signup(email: String, password: String, name: String) async throws -> User
    func refreshToken(_ token: String) async throws -> AuthToken
} 