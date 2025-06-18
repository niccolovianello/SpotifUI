//
//  PlaylistHeaderCell.swift
//  SpotifUI
//
//  Created by Niccolò Vianello on 16/06/25.
//

import SwiftUI

struct PlaylistHeaderCell: View {
    
    var height: CGFloat = 300
    var title: String = "Playlist title!"
    var description: String = "Description!"
    var imageName = Constants.randomImageURL
    
    var shadowColor: Color = .spotifyBlack.opacity(0.8)
    
    var body: some View {
        Rectangle()
            .opacity(0)
            .overlay {
                ImageLoaderView(urlString: imageName)
            }
            .overlay(alignment: .bottomLeading) {
                VStack(alignment: .leading, spacing: 8) {
                    Text(description)
                        .font(.headline)
                    Text(title)
                        .font(.largeTitle)
                        .bold()
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(
                    LinearGradient(colors: [shadowColor.opacity(0), shadowColor], startPoint: .top, endPoint: .bottom)
                )
                .foregroundStyle(.spotifyWhite)
            }
            .asStretchyHeader(startingHeight: height)
    }
}

#Preview {
    ZStack {
        Color.spotifyBlack.ignoresSafeArea()
        ScrollView() {
            PlaylistHeaderCell()
        }
        .ignoresSafeArea()
    }
}
