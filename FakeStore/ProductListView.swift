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
            switch viewModel.state {
                case .idle, .loading:
                    ProgressView()
                case .loaded(let products):
                    List(products) { product in
                        ProductRow(product: product)
                    }
                    .listStyle(.plain)
                    .navigationTitle("Products")
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
        .task { await viewModel.fetchProducts() }
    }
}

#Preview {
    ProductListView()
}
