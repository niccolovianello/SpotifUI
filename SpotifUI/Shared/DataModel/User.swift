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
    let firstName, lastName: String
    let maidenName: String?
    let age: Int?
    let email, phone, username, password: String
    let birthDate: String?
    let image: String?
    let bloodGroup: String?
    let height, weight: Double?
    let eyeColor: String?
    let ip: String?
    
    static let mock: User = User(
        id: 1,
        firstName: "John",
        lastName: "Doe",
        maidenName: "Smith",
        age: 30,
        email: "john.doe@example.com",
        phone: "+1 555-123-4567",
        username: "johndoe",
        password: "securepassword123",
        birthDate: "1995-05-20",
        image: "https://via.placeholder.com/150",
        bloodGroup: "O+",
        height: 180.0,
        weight: 75.0,
        eyeColor: "Blue",
        ip: "192.168.1.1"
    )
}
