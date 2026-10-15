//
//  ProductDetailView.swift
//  FakeStore
//
//  Created by Sergio Rodriguez on 14/10/26.
//

import SwiftUI

struct ProductDetailView: View {
    let product: Product
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                AsyncImage(url: product.image)
                    .scaledToFit()
                    .frame(width: 300, height: 300)
                    .frame(maxWidth: .infinity)
                    .background(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 25))
                Text(product.title)
                    .font(.title2)
                    .fontWeight(.semibold)
                
                HStack {
                    Text(product.price, format: .currency(code: "USD"))
                        .font(.title)
                    Spacer()
                    Text(String(product.rating.rate))
                    Text("("+String(product.rating.count)+")")
                }
                
                Text(product.category)
                    .font(.caption)
                    .padding()
                    .background(.tint.opacity(0.15), in: .capsule)
                
                Text("Description")
                    .font(.headline)
                
                Text(product.description)
                    .font(.body)
                    .foregroundStyle(.secondary)
                
            }
            .padding()
        }
        .navigationTitle(product.category)
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    ProductDetailView(product: Product(id: 1,
                                       title: "Fjallraven - Foldsack No. 1 Backpack, Fits 15 Laptops",
                                       price: 109.95,
                                       description: "Your perfect pack for everyday use and walks in the forest. Stash your laptop (up to 15 inches) in the padded sleeve, your everyday",
                                       category: "men's clothing",
                                       image: URL(string: "https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_t.png")!,
                                       rating: Rating(rate: 3.9, count: 120)
                                      )
    )
}
