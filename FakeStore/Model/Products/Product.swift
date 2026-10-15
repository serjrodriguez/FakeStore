//
//  Product.swift
//  FakeStore
//
//  Created by Sergio Rodriguez on 14/10/26.
//

import Foundation

struct Product: Codable, Identifiable, Hashable {
    var id: Int
    var title: String
    var price: Double
    var description: String
    var category: String
    var image: URL
    var rating: Rating
}

struct Rating: Codable, Hashable {
    var rate: Double
    var count: Int
}
