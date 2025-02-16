import SwiftUI
import SecureNetworking
import LoginFeature

@main
struct ExampleApp: App {
    init() {
        APIConfiguration.configure(
            with: APIConfiguration(
                baseURL: Environment.current.baseURL
            )
        )
    }
    
    // Create dependencies
    let networkService = URLSessionNetworkService()
    
    // Create repository
    let authRepository = DefaultAuthenticationRepository(
        networkService: networkService
    )
    
    // Create use case
    let loginUseCase = LoginUseCase(repository: authRepository)
    
    var body: some Scene {
        WindowGroup {
            // Create view model and view
            LoginView(
                viewModel: LoginViewModel(loginUseCase: loginUseCase)
            )
        }
    }
} 