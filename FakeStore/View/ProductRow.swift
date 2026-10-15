//
//  ProductRow.swift
//  FakeStore
//
//  Created by Sergio Rodriguez on 14/10/26.
//

import SwiftUI

struct ProductRow: View {
    let product: Product
    
    var body: some View {
        HStack(spacing: 12) {
            AsyncImage(url: product.image) { image in
                image.resizable().scaledToFit()
            } placeholder: {
                ProgressView()
            }
            .frame(width: 64, height: 64)
            .background(.white)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            
            VStack(alignment: .leading, spacing: 2) {
                Text(product.title)
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .lineLimit(2)
                Text(product.category)
                    .font(.caption)
                    .foregroundStyle(.secondary)
                Text(String(product.rating.rate))
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            
            Spacer()
            
            Text(product.price, format: .currency(code: "USD"))
                .font(.subheadline)
                .fontWeight(.medium)
        }
    }
}

#Preview {
    ProductRow(product: Product(id: 1,
                                title: "Fjallraven - Foldsack No. 1 Backpack, Fits 15 Laptops",
                                price: 109.95,
                                description: "Your perfect pack for everyday use and walks in the forest. Stash your laptop (up to 15 inches) in the padded sleeve, your everyday",
                                category: "men's clothing",
                                image: URL(string: "https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_t.png")!,
                                rating: Rating(rate: 3.9, count: 120)
                               )
    )
}
