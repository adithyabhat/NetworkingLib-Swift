import Foundation
import SecureNetworking

@MainActor
public final class LoginViewModel: ObservableObject {
    @Published private(set) var isLoading = false
    @Published private(set) var error: Error?
    
    private let loginUseCase: LoginUseCase
    
    public init(loginUseCase: LoginUseCase) {
        self.loginUseCase = loginUseCase
    }
    
    public func login(email: String, password: String) {
        guard !isLoading else { return }
        
        Task {
            do {
                isLoading = true
                error = nil
                
                let token = try await loginUseCase.execute(
                    email: email,
                    password: password
                )
                
                // Handle successful login
                print("Login successful: \(token)")
                // You might want to store the token or notify a delegate
                
            } catch {
                self.error = error
            }
            
            isLoading = false
        }
    }
} 