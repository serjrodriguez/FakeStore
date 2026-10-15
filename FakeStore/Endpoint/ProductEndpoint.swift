//
//  ProductEndpoint.swift
//  FakeStore
//
//  Created by Sergio Rodriguez on 14/10/26.
//

import Foundation

struct ProductEndpoint: Endpoint {
    var path: String
    var method: HTTPMethod
    var body: Data?
    var headers: [String : String]?
    var queryItems: [URLQueryItem]?
}
