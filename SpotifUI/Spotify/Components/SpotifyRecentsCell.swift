//
//  SpotifyRecentsCell.swift
//  SwiftUIBoost
//
//  Created by Niccolò Vianello on 28/05/25.
//

import SwiftUI

struct SpotifyRecentsCell: View {
    
    var imageName: String = Constants.randomImageURL
    var title: String = "Randomish title"
    var isPlaying: Bool = false
    var hasAudioBars: Bool = true
    
    var body: some View {
        HStack {
            ImageLoaderView(urlString: imageName)
                .frame(width: 55, height: 55)
                .clipShape(RoundedCornersShape(corners: [.topLeft, .bottomLeft], radius: 128))
            
            ZStack {
                Text(title)
                    .font(.caption)
                    .fontWeight(.semibold)
                    .lineLimit(2)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .multilineTextAlignment(.leading)
                
                if !hasAudioBars {
                    CompletionBarView(completionPercentage: 0.5, barheight: 4, trailingPadding: 16, bottomPadding: 4)
                        .frame(maxHeight: .infinity, alignment: .bottom)
                }
            }
            .frame(height: 55)
            
            if isPlaying && hasAudioBars {
                AudioBarVisualizer(barCount: 3)
                    .frame(width: 20, height: 20)
            }
            
        }
        .padding(.trailing, 8)
        .frame(maxWidth: .infinity, alignment: .leading)
        .themeColors(isSelected: false)
    }
}

#Preview {
    ZStack {
        Color.spotifyBlack
            .ignoresSafeArea()
        
        VStack {
            HStack {
                SpotifyRecentsCell(isPlaying: true)
                SpotifyRecentsCell(hasAudioBars: false)
            }
            HStack {
                SpotifyRecentsCell()
                SpotifyRecentsCell()
            }
                
        }
    }
}
