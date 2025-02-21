import Foundation

enum MockResponses {
    static let loginSuccess: [String: Any] = [
        "access_token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
        "refresh_token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
        "expires_in": 3600
    ]
    
    static let loginError: [String: Any] = [
        "error": "invalid_credentials",
        "message": "The provided credentials are incorrect"
    ]
    
    static let userProfile: [String: Any] = [
        "id": "12345",
        "email": "john.doe@example.com",
        "name": "John Doe"
    ]
    
    static func jsonData(from dict: [String: Any]) -> Data {
        try! JSONSerialization.data(withJSONObject: dict)
    }
} 