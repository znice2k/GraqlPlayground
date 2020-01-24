import Foundation
import Apollo

/*
class Network {
  static let shared = Network()
    
  private(set) lazy var apollo = ApolloClient(url: URL(string: "http://192.168.0.58:8000")!)
}

*/

// MARK: - Singleton Wrapper
class Network {
  static let shared = Network()
  
  // Configure the network transport to use the singleton as the delegate.
  private lazy var networkTransport = HTTPNetworkTransport(
    url: URL(string: "http://192.168.0.58:8000")!,
    delegate: self
  )
    
  // Use the configured network transport in your Apollo client.
  private(set) lazy var apollo = ApolloClient(networkTransport: self.networkTransport)
}

// MARK: - Pre-flight delegate

extension Network: HTTPNetworkTransportPreflightDelegate {

  func networkTransport(_ networkTransport: HTTPNetworkTransport,
                          shouldSend request: URLRequest) -> Bool {
    // If there's an authenticated user, send the request. If not, don't.
    return  false//UserManager.shared.hasAuthenticatedUser
  }
  
  func networkTransport(_ networkTransport: HTTPNetworkTransport,
                        willSend request: inout URLRequest) {
                        
    // Get the existing headers, or create new ones if they're nil
    var headers = request.allHTTPHeaderFields ?? [String: String]()

    // Add any new headers you need
    headers["Authorization"] = "Bearer"
  
    // Re-assign the updated headers to the request.
    request.allHTTPHeaderFields = headers
    
 //   Logger.log(.debug, "Outgoing request: \(request)")
  }
}

// MARK: - Task Completed Delegate

extension Network: HTTPNetworkTransportTaskCompletedDelegate {
  func networkTransport(_ networkTransport: HTTPNetworkTransport,
                        didCompleteRawTaskForRequest request: URLRequest,
                        withData data: Data?,
                        response: URLResponse?,
                        error: Error?) {
 //   Logger.log(.debug, "Raw task completed for request: \(request)")
                        
    if let error = error {
   //   Logger.log(.error, "Error: \(error)")
    }
    
    if let response = response {
//      Logger.log(.debug, "Response: \(response)")
    } else {
//      Logger.log(.error, "No URL Response received!")
    }
    
    if let data = data {
 //     Logger.log(.debug, "Data: \(String(describing: String(bytes: data, encoding: .utf8)))")
    } else {
//      Logger.log(.error, "No data received!")
    }
  }
}

// MARK: - Retry Delegate




