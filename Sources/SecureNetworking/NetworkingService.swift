import Foundation

public protocol NetworkingService {
    func request<T: Decodable>(_ request: Request) async throws -> T
    func request(_ request: Request) async throws -> Data
    func streamData(for request: Request) -> AsyncStream<Data>
    func request<T: Decodable>(_ request: Request, withTimeout timeout: TimeInterval?) async throws -> T
} 