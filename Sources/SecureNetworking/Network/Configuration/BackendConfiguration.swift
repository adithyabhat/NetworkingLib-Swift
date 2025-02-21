import Foundation

public struct BackendConfiguration {
    public let baseURL: URL
    public let version: String
    public let defaultHeaders: [String: String]
    public let timeoutInterval: TimeInterval
    
    public init(
        baseURL: URL,
        version: String,
        defaultHeaders: [String: String] = [:],
        timeoutInterval: TimeInterval = 30
    ) {
        self.baseURL = baseURL
        self.version = version
        self.defaultHeaders = defaultHeaders
        self.timeoutInterval = timeoutInterval
    }
    
    func urlWithPath(_ path: String) -> URL {
        baseURL
            .appendingPathComponent(version)
            .appendingPathComponent(path)
    }
}

public extension BackendConfiguration {
    static func backend(
        environment: NetworkEnvironment,
        version: String = "v1"
    ) -> BackendConfiguration {
        let baseURL: URL
        switch environment {
        case .development:
            baseURL = URL(string: "https://dev-api.example.com")!
        case .staging:
            baseURL = URL(string: "https://staging-api.example.com")!
        case .production:
            baseURL = URL(string: "https://api.example.com")!
        case .custom(let url):
            baseURL = URL(string: url)!
        }
        
        return BackendConfiguration(
            baseURL: baseURL,
            version: version,
            defaultHeaders: [
                "X-Environment": environment.value,
                "Content-Type": "application/json"
            ]
        )
    }
    
    static func sitecore(
        environment: NetworkEnvironment,
        version: String = "api"
    ) -> BackendConfiguration {
        let baseURL: URL
        switch environment {
        case .development:
            baseURL = URL(string: "https://dev-cms.example.com")!
        case .staging:
            baseURL = URL(string: "https://staging-cms.example.com")!
        case .production:
            baseURL = URL(string: "https://cms.example.com")!
        case .custom(let url):
            baseURL = URL(string: url)!
        }
        
        return BackendConfiguration(
            baseURL: baseURL,
            version: version,
            defaultHeaders: [
                "X-Environment": environment.value,
                "Accept": "application/json"
            ]
        )
    }
} 