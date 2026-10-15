//
//  ContentView.swift
//  FakeStore
//
//  Created by Sergio Rodriguez on 14/10/26.
//

import SwiftUI

struct ContentView: View {
    @State private var viewModel = ProductListViewModel(repository: ProductRepository())
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
        .task { await viewModel.fetchProducts() }
    }
}

#Preview {
    ContentView()
}
