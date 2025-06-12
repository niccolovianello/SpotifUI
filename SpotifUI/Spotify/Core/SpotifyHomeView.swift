//
//  SpotifyHomeView.swift
//  SwiftUIBoost
//
//  Created by Niccolò Vianello on 28/05/25.
//

import SwiftUI
import SwiftfulUI

@MainActor
@Observable
final class SpotifyHomeViewModel {
    
    @ObservationIgnored private var databaseHelper = DatabaseHelper()
    
    var currentUser: User? = nil
    var products: [Product]? = nil
    var productRows: [ProductRow]? = []
    
    func getData() async throws {
        
        do {
            currentUser = try await databaseHelper.getUsers()?.first
            let allProducts = try await databaseHelper.getProducts()
            if let allProducts {
                products = Array(allProducts.prefix(8))
                
                if let products = products {
                    var rows: [ProductRow] = []
                    let allBrands = Set(products.map( { $0.brand } ))
                    for brand in allBrands {
                        guard let brand else { continue }
//                        let brandProducts = products.filter( { $0.brand == brand })
                        rows.append(ProductRow(title: brand, products: allProducts))
                    }
                    
                    productRows = rows
                }
            }
            
        } catch {
            throw APIErrorType.invalidResponse
        }
    }
}

struct SpotifyHomeView: View {
    
    @State private var viewModel = SpotifyHomeViewModel()
    @State private var selectedCategory: Category? = nil
    
    var body: some View {
        ZStack {
            Color.spotifyBlack
                .ignoresSafeArea()
            
            ScrollView(.vertical) {
                LazyVStack(spacing: 1, pinnedViews: [.sectionHeaders]) {
                    Section {
                        VStack(spacing: 16) {
                            RecentsSectionView(products: $viewModel.products)
                                .padding(.horizontal, 16)
                            
                            
                            if let product = viewModel.products?.first {
                                newReleaseSection(product: product)
                                    .padding(.horizontal, 16)
                            }
                            
                            if let productRows = viewModel.productRows {
                                rows(rows: productRows)
                            }
                        }
                        
                    } header: {
                        header
                    }
                }
                .padding(.top, 8)
            }
            .scrollIndicators(.hidden)
            .clipped()
            
        }
        .ignoresSafeArea(edges: .bottom)
        .onAppear {
            selectedCategory = Category.allCases.first
        }
        .task {
            try? await viewModel.getData()
        }
        .toolbarVisibility(.hidden, for: .navigationBar)
    }
    
    private var header: some View {
        HStack(spacing: 0) {
            ZStack {
                if let currentUser = viewModel.currentUser,
                   let imageUrl = currentUser.image {
                    ImageLoaderView(url: imageUrl)
                        .background(.spotifyWhite)
                        .clipShape(Circle())
                        .onTapGesture {
                            
                        }
                }
            }
            .frame(width: 35, height: 35)
            
            
            ScrollView(.horizontal) {
                HStack(spacing: 8) {
                    ForEach(Category.allCases, id: \.rawValue) { category in
                        SpotifyCategoryCell(title: category.rawValue.capitalized, isSelected: category == selectedCategory)
                            .onTapGesture {
                                selectedCategory = category
                            }
                    }
                }
                .padding(.horizontal, 16)
            }
            .scrollIndicators(.hidden)
            
        }
        .padding(.vertical, 24)
        .padding(.leading, 8)
        .background(Color.spotifyBlack)
    }
    
    private func newReleaseSection(product: Product) -> some View {
        SpotifyNewReleaseCell(
            imageName: product.thumbnail,
            headerTitle: product.brand,
            headerDescription: String(product.price ?? 0),
            detailTitle: product.title,
            detailDescription: product.description
        )
    }
    
    private func rows(rows: [ProductRow]) -> some View {
        ForEach(rows) { row in
            Text(row.title)
                .foregroundStyle(.spotifyWhite)
                .font(.title)
                .fontWeight(.semibold)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 16)
            
            ScrollView(.horizontal) {
                HStack(spacing: 16) {
                    ForEach(row.products) { product in
                        SpotifyCardView(text: product.title, imageName: product.thumbnail, lineLimit: 1)
                    }
                }
                .padding(.horizontal, 16)
            }
            .scrollIndicators(.hidden)
        }
    }
}

struct RecentsSectionView: View {
    
    @Binding var products: [Product]?
    
    var body: some View {
        if let products {
            NonLazyVGrid(columns: 2, alignment: .center, spacing: 10, items: products) { product in
                if let product {
                    SpotifyRecentsCell(imageName: product.thumbnail, title: product.title)
                        .makeButton(.press) {
                            
                        }
                }
            }
        }
    }
}

#Preview {
    SpotifyHomeView()
}
