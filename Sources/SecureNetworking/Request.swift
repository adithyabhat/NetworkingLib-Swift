import Foundation

public struct Request {
    public let url: URL
    public let method: HTTPMethod
    public var headers: [String: String]
    public var queryItems: [URLQueryItem]?
    public var body: Data?
    public var timeoutInterval: TimeInterval
    
    public init(
        url: URL,
        method: HTTPMethod = .get,
        headers: [String: String] = [:],
        queryItems: [URLQueryItem]? = nil,
        body: Data? = nil,
        timeoutInterval: TimeInterval = 30
    ) {
        self.url = url
        self.method = method
        self.headers = headers
        self.queryItems = queryItems
        self.body = body
        self.timeoutInterval = timeoutInterval
    }
    
    internal func asURLRequest() throws -> URLRequest {
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
        components?.queryItems = queryItems
        
        guard let finalURL = components?.url else {
            throw NetworkError.invalidURL
        }
        
        var request = URLRequest(url: finalURL)
        request.httpMethod = method.name
        request.allHTTPHeaderFields = headers
        request.httpBody = body
        request.timeoutInterval = timeoutInterval
        
        return request
    }
} 