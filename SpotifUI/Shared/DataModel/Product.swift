//
//  Product.swift
//  SwiftUIBoost
//
//  Created by Niccolò Vianello on 28/05/25.
//

import Foundation

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let product = try? JSONDecoder().decode(Product.self, from: jsonData)

import Foundation

// MARK: - Product
struct ProductArray: Codable {
    let products: [Product]?
    let total, skip, limit: Int?
}

// MARK: - ProductElement
struct Product: Codable, Identifiable {
    let id: Int?
    let title, description: String?
    let price, discountPercentage, rating: Double?
    let stock: Int?
    let tags: [String]?
    let brand, sku: String?
    let images: [String]?
    let thumbnail: String?
}

struct ProductRow: Identifiable {
    let id = UUID().uuidString
    let title: String
    let products: [Product]
}
