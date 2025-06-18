//
//  ProductArray.swift
//  SpotifUI
//
//  Created by Niccolò Vianello on 18/06/25.
//


import Foundation

// MARK: - Product
struct ProductArray: Codable {
    let products: [Product]?
    let total, skip, limit: Int?
}

// MARK: - ProductElement
struct Product: Codable, Identifiable, Hashable {
    let id: Int
    let title, description: String
    let price, discountPercentage, rating: Double?
    let stock: Int?
    let tags: [String]?
    let brand, sku: String?
    let images: [String]?
    let thumbnail: String
    let category: String
    
    static let mock: Product = Product(
        id: 1,
        title: "Mock Product",
        description: "This is a mock product used for testing purposes.",
        price: 99.99,
        discountPercentage: 15.0,
        rating: 4.5,
        stock: 42,
        tags: ["mock", "test", "demo"],
        brand: "MockBrand",
        sku: "MOCKSKU123",
        images: [],
        thumbnail: Constants.randomImageURL,
        category: "Electronic devices"
    )
}

struct ProductRow: Identifiable {
    let id = UUID().uuidString
    let title: String
    let products: [Product]
}
