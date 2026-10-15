//
//  ProductListViewModel.swift
//  FakeStore
//
//  Created by Sergio Rodriguez on 14/10/26.
//

import Foundation

enum ProductListState {
    case idle
    case loading
    case loaded([Product])
    case failed(String)
}

@Observable @MainActor
class ProductListViewModel{
    private var repository: ProductRepositoryProtocol
        
    var state: ProductListState = .idle
    
    init(repository: ProductRepositoryProtocol) {
        self.repository = repository
    }
    
    func fetchProducts() async {
        state = .loading
        
        do {
            state = .loaded(try await repository.fetchProducts())
        } catch {
            state = .failed(error.localizedDescription)
        }
    }
}
