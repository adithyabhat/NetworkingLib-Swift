public struct APIConfiguration {
    public let baseURL: URL
    public let version: String
    
    public init(baseURL: URL, version: String = "v1") {
        self.baseURL = baseURL
        self.version = version
    }
    
    static var current: APIConfiguration!
    
    public static func configure(with configuration: APIConfiguration) {
        Self.current = configuration
    }
} 