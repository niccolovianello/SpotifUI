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

// MARK: Users
struct UserArray: Codable {
    let users: [User]?
    let total, skip, limit: Int?
}

// MARK: - User
struct User: Codable, Identifiable {
    let id: Int?
    let firstName, lastName, maidenName: String?
    let age: Int?
    let email, phone, username, password: String?
    let birthDate: String?
    let image: String?
    let bloodGroup: String?
    let height, weight: Double?
    let eyeColor: String?
    let ip: String?
}
