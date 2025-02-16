import SwiftUI
import SecureNetworking

public struct LoginView: View {
    @StateObject private var viewModel: LoginViewModel
    @State private var email = ""
    @State private var password = ""
    
    public init(viewModel: LoginViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    public var body: some View {
        ZStack {
            VStack(spacing: 20) {
                Text("Welcome Back")
                    .font(.title)
                    .fontWeight(.bold)
                
                VStack(spacing: 16) {
                    TextField("Email", text: $email)
                        .textFieldStyle(.roundedBorder)
                        .textInputAutocapitalization(.never)
                        .keyboardType(.emailAddress)
                        .autocorrectionDisabled()
                    
                    SecureField("Password", text: $password)
                        .textFieldStyle(.roundedBorder)
                }
                .padding(.vertical)
                
                Button {
                    viewModel.login(email: email, password: password)
                } label: {
                    Text("Login")
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .disabled(viewModel.isLoading)
                
                if let error = viewModel.error {
                    Text(error.localizedDescription)
                        .font(.callout)
                        .foregroundColor(.red)
                        .padding(.horizontal)
                        .multilineTextAlignment(.center)
                }
            }
            .padding(.horizontal, 24)
            
            if viewModel.isLoading {
                LoadingView("Logging in...")
            }
        }
    }
}

#Preview {
    LoginView(viewModel: LoginViewModel(
        loginUseCase: LoginUseCase(
            repository: DefaultAuthenticationRepository(
                networkService: URLSessionNetworkService()
            )
        )
    ))
} 