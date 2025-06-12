//
//  SpotifyRecentsCell.swift
//  SwiftUIBoost
//
//  Created by Niccolò Vianello on 28/05/25.
//

import SwiftUI

struct SpotifyRecentsCell: View {
    
    var imageName: String? = Constants.randomImageURL
    var title: String? = "Randomish title"
    var isPlaying: Bool = false
    
    var body: some View {
        HStack {
            ImageLoaderView(url: imageName)
                .frame(width: 55, height: 55)
            
            Text(title ?? "No title")
                .font(.caption)
                .fontWeight(.semibold)
                .lineLimit(2)
            
        }
        .padding(.trailing, 8)
        .frame(maxWidth: .infinity, alignment: .leading)
        .themeColors(isSelected: false)
        .cornerRadius(6)
    }
}

#Preview {
    ZStack {
        Color.spotifyBlack
            .ignoresSafeArea()
        
        VStack {
            HStack {
                SpotifyRecentsCell(isPlaying: true)
                SpotifyRecentsCell()
            }
            HStack {
                SpotifyRecentsCell()
                SpotifyRecentsCell()
            }
                
        }
    }
}
