import Foundation

public struct NetworkConfiguration {
    private let configurations: [BackendType: BackendConfiguration]
    
    public init(environment: NetworkEnvironment) {
        self.configurations = [
            .backend: .backend(environment: environment),
            .sitecore: .sitecore(environment: environment)
        ]
    }
    
    public init(configurations: [BackendType: BackendConfiguration]) {
        self.configurations = configurations
    }
    
    func configuration(for type: BackendType) -> BackendConfiguration {
        guard let config = configurations[type] else {
            fatalError("Configuration not found for backend type: \(type)")
        }
        return config
    }
}

public extension NetworkConfiguration {
    static func custom(
        backendURL: String,
        sitecoreURL: String
    ) -> NetworkConfiguration {
        NetworkConfiguration(configurations: [
            .backend: .backend(environment: .custom(backendURL)),
            .sitecore: .sitecore(environment: .custom(sitecoreURL))
        ])
    }
} 