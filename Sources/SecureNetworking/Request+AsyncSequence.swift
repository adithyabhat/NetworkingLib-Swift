import Foundation

public extension Request {
    func asyncBytes(using client: NetworkClient) -> AsyncStream<Data> {
        client.streamData(for: self, delegate: DefaultURLSessionDataDelegate())
    }
} 