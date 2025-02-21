import SwiftUI
import SecureNetworking
import LoginFeature

@main
struct ExampleApp: App {
    let networkConfiguration: NetworkConfiguration = {
        #if DEBUG
        return NetworkConfiguration(environment: .development)
        #else
        return NetworkConfiguration(environment: .production)
        #endif
    }()
    
    // For custom URLs:
    // let networkConfiguration = NetworkConfiguration.custom(
    //     backendURL: "https://custom-api.example.com",
    //     sitecoreURL: "https://custom-cms.example.com"
    // )
    
    let requestBuilder: RequestBuilder
    let authRepository: AuthenticationRepository
    let loginUseCase: LoginUseCase
    
    init() {
        self.requestBuilder = RequestBuilder(
            configuration: networkConfiguration
        )
        
        #if DEBUG
        self.authRepository = MockAuthenticationRepository(
            shouldSimulateError: false,
            responseDelay: 1.0
        )
        #else
        self.authRepository = DefaultAuthenticationRepository(
            networkService: URLSessionNetworkService(),
            requestBuilder: requestBuilder
        )
        #endif
        
        self.loginUseCase = LoginUseCase(repository: authRepository)
    }
    
    var body: some Scene {
        WindowGroup {
            LoginView(
                viewModel: LoginViewModel(loginUseCase: loginUseCase)
            )
        }
    }
} 