//
//  PlaylistDescriptionCell.swift
//  SpotifUI
//
//  Created by Niccolò Vianello on 16/06/25.
//

import SwiftUI

struct PlaylistDescriptionCell: View {
    
    var descriptionText: String = "This is a very long description of this content. Please leave a maximum of 2 lines."
    
    var username: String = "username"
    var subHeadlineText: String = "Sub headline goes here"
    
    var onAddToPlaylistPressed: (() -> Void)? = nil
    var onDownloadPressed: (() -> Void)? = nil
    var onPlayPressed: (() -> Void)? = nil
    var onSharePressed: (() -> Void)? = nil
    var onShufflePressed: (() -> Void)? = nil
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(descriptionText)
                .foregroundStyle(.spotifyLightGray)
                .lineLimit(2)
            
            madeForYou
            
            Text(subHeadlineText)
            
            buttons
            
        }
        .font(.callout)
        .foregroundStyle(.spotifyLightGray)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var madeForYou: some View {
        HStack(spacing: 8) {
            Image(systemName: "applelogo")
                .font(.title3)
                .foregroundStyle(.spotifyGreen)
            
            Text("Made for ")
            +
            Text(username)
                .bold()
                .foregroundStyle(.spotifyLightGray)
        }
    }
    
    private var buttons: some View {
        HStack(spacing: 0) {
            HStack(spacing: 0) {
                Image(systemName: "plus.circle")
                    .padding(8)
                    .background(.spotifyBlack.opacity(0.001))
                    .makeButton {
                        onAddToPlaylistPressed?()
                    }
                
                Image(systemName: "arrow.down.circle")
                    .padding(8)
                    .background(.spotifyBlack.opacity(0.001))
                    .makeButton {
                        onDownloadPressed?()
                    }
                
                Image(systemName: "square.and.arrow.up")
                    .padding(8)
                    .background(.spotifyBlack.opacity(0.001))
                    .makeButton {
                        onSharePressed?()
                    }
                
                Image(systemName: "ellipsis")
                    .padding(8)
                    .background(.spotifyBlack.opacity(0.001))
                    .makeButton {
                        onAddToPlaylistPressed?()
                    }
            }
            .offset(x: -8)
            .frame(maxWidth: .infinity, alignment: .leading)
            
            HStack(spacing: 8) {
                Image(systemName: "shuffle")
                    .padding(8)
                    .background(.spotifyBlack.opacity(0.001))
                    .makeButton {
                        onShufflePressed?()
                    }
                
                Image(systemName: "play.circle.fill")
                    .padding(8)
                    .font(.system(size: 46))
                    .background(.spotifyBlack.opacity(0.001))
                    .makeButton {
                        onPlayPressed?()
                    }
            }
            .foregroundStyle(.spotifyGreen)
        }
        .font(.title2)
    }
}

#Preview {
    ZStack {
        Color.spotifyBlack
            .ignoresSafeArea()
        
        PlaylistDescriptionCell()
            .padding()
    }
}
