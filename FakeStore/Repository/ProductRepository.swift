//
//  ProductRepository.swift
//  FakeStore
//
//  Created by Sergio Rodriguez on 14/10/26.
//

protocol ProductRepositoryProtocol {
    func fetchProducts() async throws -> [Product]
}

class ProductRepository: ProductRepositoryProtocol {
    private var apiClient: APIClientProtocol
    
    init(apiClient: APIClientProtocol = APIClient()) {
        self.apiClient = apiClient
    }
    
    func fetchProducts() async throws -> [Product] {
        let endpoint = ProductEndpoint(path: "products",
                                       method: .GET,
                                       body: nil,
                                       headers: nil,
                                       queryItems: nil
        )
        
        let result: [Product] = try await apiClient.sendRequest(endpoint)
        
        return result
    }
}
