//
//  SpotifyHomeView.swift
//  SwiftUIBoost
//
//  Created by Niccolò Vianello on 28/05/25.
//

import SwiftUI

@MainActor
@Observable
final class SpotifyHomeViewModel {
    
    @ObservationIgnored private var apiHelper = APIHelper()
    
    var currentUser: User? = nil
    var products: [Product]? = []
    var productRows: [ProductRow]? = []
    
    func getData() async throws {
        
        do {
            currentUser = try await apiHelper.fetchUsers().users?.first
            let productArray = try await apiHelper.fetchProducts()
            if let products = productArray.products {
                self.products = Array(products.prefix(8))
                
                var rows: [ProductRow] = []
                let allBrands = Set(products.map( \.brand ))
                for brand in allBrands {
                    if let brand {
                        rows.append(ProductRow(title: brand, products: products))
                    }
                }
                
                productRows = rows
            }
            
        } catch {
            throw APIError.invalidResponse
        }
    }
}

struct SpotifyHomeView: View {
    
    @State private var viewModel = SpotifyHomeViewModel()
    @State private var selectedCategory: CategoryType = .all
    
    var body: some View {
        NavigationStack {
            
            ZStack {
                Color.spotifyBlack.ignoresSafeArea()
                
                ScrollView(.vertical) {
                    LazyVStack(spacing: 1, pinnedViews: [.sectionHeaders]) {
                        Section {
                            
                            switch selectedCategory {
                            case .all:
                                allSection
                            case .music:
                                musicSection
                            case .podcasts:
                                podcastsSection
                            }
                            
                        } header: {
                            header
                        }
                    }
                    .padding(.top, 8)
                }
                .scrollIndicators(.hidden)
                .clipped()
                .navigationDestination(for: Product.self) { product in
                    SpotifyPlaylistView(product: product)
                }
            }
            .ignoresSafeArea(edges: .bottom)
            
        }
        .onAppear {
            selectedCategory = CategoryType.allCases.first ?? .all
        }
        .task {
            try? await viewModel.getData()
        }
        .toolbarVisibility(.hidden, for: .navigationBar)
    }
    
    private var header: some View {
        HStack(spacing: 0) {
            ZStack(alignment: .leading) {   
                
                ScrollView(.horizontal) {
                    HStack(spacing: 8) {
                        ForEach(CategoryType.allCases, id: \.rawValue) { category in
                            SpotifyCategoryCell(title: category.category.name.capitalized, isSelected: category == selectedCategory, expandOnSelect: category.category.expandOnSelection, expandedText: category.category.expandedCategory)
                                .onTapGesture {
                                    selectedCategory = category
                                }
                        }
                    }
                    .padding(.horizontal, 48)
                }
                .scrollIndicators(.hidden)
                
                ZStack {
                    
                    if let currentUser = viewModel.currentUser,
                       let imageUrl = currentUser.image {
                        ImageLoaderView(urlString: imageUrl)
                            .glassEffect(.regular)
                            .clipShape(Circle())
                            .onTapGesture {
                                
                            }
                            .frame(width: 35, height: 35)
                    }
                }
            }
            .wrapInGlassContainer()
        }
        .padding(.vertical)
        .padding(.leading)
        
    }
    
    private var allSection: some View {
        VStack(spacing: 16) {
            RecentsSectionView(products: $viewModel.products)
                .padding(.horizontal, 16)
                .wrapInGlassContainer()
                
            
            if let product = viewModel.products?.first {
                newReleaseSection(product: product)
                    .padding(.horizontal, 16)
            }
            
            if let productRows = viewModel.productRows {
                rows(rows: productRows)
            }
        }
    }
    
    private var musicSection: some View {
        Text("Music")
            .padding()
            .foregroundStyle(.spotifyWhite)
    }
    
    private var podcastsSection: some View {
        Text("Podcasts")
            .padding()
            .foregroundStyle(.spotifyWhite)
    }
    
    private func newReleaseSection(product: Product) -> some View {
        SpotifyNewReleaseCell(
            headerDescription: product.brand,
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
                        SpotifyCardView(text: product.title, lineLimit: 1)
                    }
                }
                .padding(.horizontal, 16)
            }
            .wrapInGlassContainer()
            .scrollIndicators(.hidden)
        }
    }
}

struct RecentsSectionView: View {
    
    @Binding var products: [Product]?
    
    var body: some View {
        if let products {
            NonLazyVGrid(columns: 2, alignment: .center, spacing: 8, items: products) { product in
                if let product {
                    NavigationLink(value: product) {
                        SpotifyRecentsCell(title: product.title, isPlaying: product.id == 1, hasAudioBars: product.id != 4)
                    }
                }
            }
        }
    }
}

#Preview {
    SpotifyHomeView()
}
