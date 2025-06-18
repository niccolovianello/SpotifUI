//
//  SpotifyPlaylistView.swift
//  SpotifUI
//
//  Created by Niccolò Vianello on 16/06/25.
//

import SwiftUI

@MainActor
@Observable
final class SpotifyPlaylistViewModel {
    
    var products: [Product] = []
    
    @ObservationIgnored private var apiHelper = APIHelper()
    
    func getPlaylistData() async {
        if let products = try? await apiHelper.fetchProducts().products {
            self.products = products
        }
    }
}

struct SpotifyPlaylistView: View {
    
    @State private var viewModel = SpotifyPlaylistViewModel()
    var product: Product = .mock
    var user: User = .mock
    
    var body: some View {
        ZStack {
            ScrollView(.vertical) {
                LazyVStack(spacing: 12) {
                    
                    
                    PlaylistHeaderCell(
                        height: 250,
                        title: product.title,
                        description: product.description,
                        imageName: product.thumbnail
                    )
                    .readingFrame { frame in
                        showHeader = frame.maxY < 150
                    }
                    
                    PlaylistDescriptionCell(descriptionText: String(product.description), username: user.firstName, subHeadlineText: product.category)
                        .padding(.horizontal)
                    
                    ForEach(viewModel.products, id: \.id) { product in
                        SongRowCell(
                            imageName: product.thumbnail,
                            title: product.title,
                            artist: product.brand ?? "Unknown"
                        )
                        .padding(.leading)
                    }
                }
            }
            .scrollIndicators(.hidden)
        }
        .task {
            await viewModel.getPlaylistData()
        }
    }
}

#Preview {
    ZStack {
        Color.spotifyBlack
            .ignoresSafeArea()
        
        SpotifyPlaylistView(product: .mock)
    }
}

