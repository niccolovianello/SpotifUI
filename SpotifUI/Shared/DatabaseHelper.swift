//
//  DatabaseHelper.swift
//  SwiftUIBoost
//
//  Created by Niccolò Vianello on 28/05/25.
//

import Foundation

enum APIErrorType: Error {
    case invalidResponse
    case decodingError
}

struct DatabaseHelper {
    func getProducts() async throws -> [Product]? {
        
        guard let url = URL(string: Constants.productsURL),
              let products = try? await URLSession.shared.decode(ProductArray.self, from: url) else {
            throw APIErrorType.decodingError
        }
        
        return products.products
    }
    
    func getUsers() async throws -> [User]? {
        
        guard let url = URL(string: Constants.usersURL),
              let users = try? await URLSession.shared.decode(UserArray.self, from: url) else {
            throw APIErrorType.decodingError
        }
        
        return users.users
    }
}
