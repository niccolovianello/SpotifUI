//
//  SpotifyNewReleaseView.swift
//  SwiftUIBoost
//
//  Created by Niccolò Vianello on 28/05/25.
//

import SwiftUI

struct SpotifyNewReleaseCell: View {
    
    var imageName: String? = Constants.randomImageURL
    
    var headerTitle: String? = "New Release"
    var headerDescription: String? = "Taylor Swift - Midnights"
    var headerTitleColor: Color? = .spotifyLightGray
    var headerDescriptionColor: Color? = .spotifyWhite
    
    var detailTitle: String? = "iPhone 16"
    var detailDescription: String? = "Apple device that discovers Intelligence."
    var detailTitleColor: Color? = .spotifyWhite
    var detailDescriptionColor: Color? = .spotifyLightGray
    
    var onAddedToPlaylistPressed: (() -> Void)? = nil
    var onPlayPressed: (() -> Void)? = nil
    
    @State private var isAddedToPlaylist: Bool = false
    
    var body: some View {
        VStack {
            sectionHeader
                .frame(maxWidth: .infinity, alignment: .leading)
            
            HStack {
                ImageLoaderView(url: imageName)
                    .frame(width: 150, height: 150)
                    .clipShape(RoundedCornersShape(corners: [.topLeft, .bottomLeft], radius: 16))
                
                VStack(alignment: .leading, spacing: 32) {
                    
                    sectionDetail
                    
                    sectionButtons
                    
                }
            }
            .padding(.trailing, 16)
            .glassEffect(.regular.tint(.spotifyBlack).interactive(), in: .rect(cornerRadius: 16))
            .onTapGesture {
                onPlayPressed?()
            }
            
        }
    }
    
    private var sectionHeader: some View {
        HStack(spacing: 8) {
            ImageLoaderView()
                .frame(width: 50, height: 50)
                .clipShape(Circle())
            
            VStack(alignment: .leading, spacing: 2) {
                if let headerTitle {
                    Text(headerTitle)
                        .font(.callout)
                        .foregroundStyle(headerTitleColor ?? .spotifyWhite)
                }
                
                if let headerDescription {
                    Text(headerDescription)
                        .font(.title2)
                        .fontWeight(.medium)
                        .foregroundStyle(headerDescriptionColor ?? .spotifyWhite)
                }
            }
        }
    }
    
    private var sectionDetail: some View {
        VStack(alignment: .leading, spacing: 2) {
            if let detailTitle {
                Text(detailTitle)
                    .foregroundStyle(detailTitleColor ?? .spotifyWhite)
                    .fontWeight(.semibold)
            }
            
            if let detailDescription {
                Text(detailDescription)
                    .lineLimit(1)
                    .foregroundStyle(detailDescriptionColor ?? .spotifyWhite)
            }
        }
        .font(.callout)
    }
    
    private var sectionButtons: some View {
        HStack(spacing: 0) {
            Image(systemName: isAddedToPlaylist ? "checkmark.circle.fill" : "plus.circle")
                .foregroundStyle(isAddedToPlaylist ? .spotifyGreen : .spotifyLightGray)
                .font(.title3)
                .onTapGesture {
                    
                    isAddedToPlaylist.toggle()
                    
                    onAddedToPlaylistPressed?()
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Image(systemName: "play.circle.fill")
                .foregroundStyle(.spotifyWhite)
                .font(.title)
        }
        
    }
}

#Preview {
    ZStack {
        Color.spotifyBlack.ignoresSafeArea()
        
        SpotifyNewReleaseCell()
            .padding()
    }
}
