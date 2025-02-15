import Foundation

public actor URLSessionNetworkService: NetworkingService {
    private let session: URLSession
    private let decoder: JSONDecoder
    
    public init(
        configuration: URLSessionConfiguration = .default,
        decoder: JSONDecoder = JSONDecoder()
    ) {
        self.session = URLSession(configuration: configuration)
        self.decoder = decoder
    }
    
    public func request<T: Decodable>(_ request: Request) async throws -> T {
        let urlRequest = try request.asURLRequest()
        
        let (data, response) = try await session.data(for: urlRequest)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.invalidStatusCode(-1)
        }
        
        guard (200...299).contains(httpResponse.statusCode) else {
            throw NetworkError.invalidStatusCode(httpResponse.statusCode)
        }
        
        do {
            return try decoder.decode(T.self, from: data)
        } catch {
            throw NetworkError.decodingFailed
        }
    }
    
    public func request(_ request: Request) async throws -> Data {
        let urlRequest = try request.asURLRequest()
        
        let (data, response) = try await session.data(for: urlRequest)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.invalidStatusCode(-1)
        }
        
        guard (200...299).contains(httpResponse.statusCode) else {
            throw NetworkError.invalidStatusCode(httpResponse.statusCode)
        }
        
        return data
    }
    
    public func streamData(for request: Request) -> AsyncStream<Data> {
        AsyncStream { continuation in
            let session = URLSession(
                configuration: self.session.configuration,
                delegate: URLSession.shared.delegate ?? URLSessionDataDelegate(),
                delegateQueue: nil
            )
            
            Task {
                do {
                    let urlRequest = try request.asURLRequest()
                    let (bytes, response) = try await session.bytes(for: urlRequest)
                    
                    guard let httpResponse = response as? HTTPURLResponse,
                          (200...299).contains(httpResponse.statusCode) else {
                        continuation.finish()
                        return
                    }
                    
                    for try await byte in bytes {
                        continuation.yield(Data([byte]))
                    }
                    
                    continuation.finish()
                } catch {
                    continuation.finish()
                }
            }
        }
    }
    
    public func request<T: Decodable>(
        _ request: Request,
        withTimeout timeout: TimeInterval?
    ) async throws -> T {
        try await withThrowingTaskGroup(of: T.self) { group in
            group.addTask {
                try await self.request(request)
            }
            
            if let timeout {
                group.addTask {
                    try await Task.sleep(nanoseconds: UInt64(timeout * 1_000_000_000))
                    throw NetworkError.timeout
                }
            }
            
            return try await group.next() ?? { throw NetworkError.noData }()
        }
    }
} 