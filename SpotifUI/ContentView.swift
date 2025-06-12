//
//  ContentView.swift
//  SwiftUIBoost
//
//  Created by Niccolò Vianello on 28/05/25.
//

import SwiftUI


struct ContentView: View {
    
    @State var users: [User]? = []
    @State var products: [Product]? = []
    
    var body: some View {
        ScrollView {
            VStack {
                if let products = products {
                    ForEach(products) { product in
                        Text(product.title ?? "no name")
                    }
                }
            }
        }
        .task {
            try? await getData()
        }
    }
    
    func getData() async throws {
        users = try? await DatabaseHelper().getUsers()
        products = try? await DatabaseHelper().getProducts()
    }
}

#Preview {
    ContentView()
}
