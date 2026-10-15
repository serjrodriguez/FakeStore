//
//  ContentView.swift
//  FakeStore
//
//  Created by Sergio Rodriguez on 14/10/26.
//

import SwiftUI

struct ProductListView: View {
    @State private var viewModel = ProductListViewModel(repository: ProductRepository())
    
    var body: some View {
        NavigationStack {
            VStack {
                switch viewModel.state {
                    case .idle, .loading:
                        ProgressView()
                    case .loaded(let products):
                        List(products) { product in
                            NavigationLink(value: product) {
                                ProductRow(product: product)
                            }
                        }
                        .listStyle(.plain)
                        .navigationDestination(for: Product.self) { product in
                            ProductDetailView(product: product)
                        }
                    case .failed(let message):
                        ContentUnavailableView {
                            Label("Couldn't load products", systemImage: "wifi.slash")
                        } description: {
                            Text(message)
                        } actions: {
                            Button("Retry") {
                                Task { await viewModel.fetchProducts() }
                            }
                        }
                }
            }
            .navigationTitle("Products")
        }
        .task { await viewModel.fetchProducts() }
    }
}

#Preview {
    ProductListView()
}
