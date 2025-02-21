import Foundation

public class DefaultURLSessionDataDelegate: NSObject, URLSessionDataDelegate {
    public override init() {
        super.init()
    }
    
    public func urlSession(
        _ session: URLSession,
        dataTask: URLSessionDataTask,
        didReceive data: Data
    ) {
        // Custom handling of received data
    }
    
    public func urlSession(
        _ session: URLSession,
        task: URLSessionTask,
        didCompleteWithError error: Error?
    ) {
        // Custom error handling
    }
} 