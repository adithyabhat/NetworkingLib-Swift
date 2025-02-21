import Foundation

public struct RequestBuilder {
    private let configuration: NetworkConfiguration
    
    public init(configuration: NetworkConfiguration) {
        self.configuration = configuration
    }
    
    public func buildRequest(for endpoint: NetworkEndpoint) throws -> Request {
        let backendConfig = configuration.configuration(for: endpoint.backendType)
        
        // Combine backend default headers with endpoint specific headers
        var headers = backendConfig.headers
        endpoint.headers.forEach { headers[$0.key] = $0.value }
        
        return Request(
            url: backendConfig.urlWithPath(endpoint.path),
            method: endpoint.method,
            headers: headers,
            queryItems: endpoint.queryItems,
            timeoutInterval: backendConfig.timeout
        )
    }
} 