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
    
    var releaseResource: Resource? = nil
    
    @ObservationIgnored private var apiHelper = APIHelper()
    
    func getReleaseInfo(release: Release?) async {
        releaseResource = try? await apiHelper.fetchResource(from: release)
    }
}

struct SpotifyPlaylistView: View {
    
    @State private var viewModel = SpotifyPlaylistViewModel()
    var release: Release? = nil
    
    var body: some View {
        VStack {
            if let resource = viewModel.releaseResource {
                ScrollView(.vertical) {
                    LazyVStack(spacing: 12) {
                        PlaylistHeaderCell(
                            height: 250,
                            title: resource.title,
                            description: resource.artists.compactMap( \.name ).joined(separator: " & "),
                            imageName: resource.thumb
                        )
                        
                        PlaylistDescriptionCell(descriptionText: String(resource.year))
                            .padding(.horizontal)
                    }
                }
            }
        }
        .scrollIndicators(.hidden)
        .task {
            await viewModel.getReleaseInfo(release: release)
        }
    }
}

#Preview {
    ZStack {
        Color.spotifyBlack
            .ignoresSafeArea()
        
        SpotifyPlaylistView(release: .mock)
    }
}

