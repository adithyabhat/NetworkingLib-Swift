import Foundation

public extension Request {
    static func json<T: Encodable>(
        url: URL,
        method: HTTPMethod,
        body: T,
        encoder: JSONEncoder = JSONEncoder()
    ) throws -> Request {
        let data = try encoder.encode(body)
        var headers = [String: String]()
        headers["Content-Type"] = "application/json"
        
        return Request(
            url: url,
            method: method,
            headers: headers,
            body: data
        )
    }
} 