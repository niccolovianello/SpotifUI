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
    @State private var showHeader: Bool = true
    
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
            
            header
                .padding(.horizontal)
                .foregroundStyle(.spotifyWhite)
                .frame(maxHeight: .infinity, alignment: .top)
                .animation(.smooth(duration: 0.2), value: showHeader)
        }
        .task {
            await viewModel.getPlaylistData()
        }
        .toolbar(.hidden, for: .navigationBar)
    }
    
    private var header: some View {
        ZStack {
            
            Text(product.title)
                .padding(.vertical, 20)
                .frame(maxWidth: .infinity)
                .opacity(showHeader ? 1 : 0)
                .offset(y: showHeader ? 0 : -30)
                .glassEffect(isEnabled: showHeader)
            
            HStack {
                Image(systemName: "chevron.left")
                    .font(.title3)
                    .padding(10)
                    .background(showHeader ? .black.opacity(0.001) : .spotifyGray.opacity(0.7))
                    .clipShape(Circle())
                    .padding(.leading)
                    .offset(x: showHeader ? 0 : -10)
                    .makeButton(.press) {
                        
                    }
                
                Spacer()
            }
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

