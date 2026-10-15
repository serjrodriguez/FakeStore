//
//  APIClient.swift
//  FakeStore
//
//  Created by Sergio Rodriguez on 14/10/26.
//

import Foundation

enum HTTPMethod: String {
    case GET
    case POST
    case PUT
    case DELETE
    case PATCH
}

enum HTTPError: Error, LocalizedError {
    case malformedURL
    case invalidHTTPResponse(code: Int)
    case networkError(code: Int)
    case decodingError
    
    var errorDescription: String? {
        switch self {
            case .malformedURL:
                "The request URL is invalid."
            case .invalidHTTPResponse(let code):
                "The server sent an unexpected response. \(code)"
            case .networkError(let code):
                "The server returned an error. \(code)"
            case .decodingError:
                "We couldn't read the data from the server."
        }
    }
}

protocol Endpoint {
    var path: String { get set }
    var method: HTTPMethod { get set }
    var body: Data? { get set }
    var headers: [String: String]? { get set }
    var queryItems: [URLQueryItem]? { get set }
}

protocol APIClientProtocol {
    func sendRequest<T: Decodable>(_ endpoint: Endpoint) async throws -> T
}

class APIClient: APIClientProtocol {
    private let baseURL = "https://fakestoreapi.com/"
    private var session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func sendRequest<T: Decodable>(_ endpoint: Endpoint) async throws -> T {
        let URLString = "\(baseURL)\(endpoint.path)"
        
        guard var url = URL(string: URLString) else {
            throw HTTPError.malformedURL
        }
        
        if let queryItems = endpoint.queryItems {
            url.append(queryItems: queryItems)
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpBody = endpoint.body
        urlRequest.httpMethod = endpoint.method.rawValue
        urlRequest.timeoutInterval = 30.0
        urlRequest.cachePolicy = .reloadIgnoringLocalCacheData
        
        if let headers = endpoint.headers {
            for header in headers {
                urlRequest.setValue(header.value, forHTTPHeaderField: header.key)
            }
        }
        
        let (data, response) = try await session.data(for: urlRequest)
        
        guard let response = response as? HTTPURLResponse else {
            throw HTTPError.invalidHTTPResponse(code: 0)
        }
        
        guard (200...299).contains(response.statusCode) else {
            throw HTTPError.networkError(code: response.statusCode)
        }
        
        do {
            let decodedData = try JSONDecoder().decode(T.self, from: data)
            return decodedData
        } catch {
            throw HTTPError.decodingError
        }
    }
}
