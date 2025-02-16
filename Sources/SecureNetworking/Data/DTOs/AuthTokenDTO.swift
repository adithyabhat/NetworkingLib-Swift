struct AuthTokenDTO: Decodable {
    let access_token: String
    let refresh_token: String
    let expires_in: Int
    
    func toDomain() -> AuthToken {
        AuthToken(
            accessToken: access_token,
            refreshToken: refresh_token,
            expiresIn: expires_in
        )
    }
} 