//
//  SpotifyCardView.swift
//  SwiftUIBoost
//
//  Created by Niccolò Vianello on 04/06/25.
//

import SwiftUI

struct SpotifyCardView: View {
    
    var text: String? = "_product_name_agkdhbwkehbfkqwbkdbqkwhbdkhbqkwhbdc"
    var imageName: String? = Constants.randomImageURL
    var imageSize: CGFloat = 120
    var lineLimit: Int = 2
    
    var body: some View {
        VStack {
            ImageLoaderView(url: imageName)
                .frame(width: imageSize, height: imageSize)
            
            Text(text ?? "_no_name")
                .padding(4)
                .lineLimit(lineLimit)
                .font(.callout)
                .foregroundStyle(.spotifyLightGray)
        }
        .frame(width: imageSize)
    }
}

#Preview {
    ZStack {
        Color.spotifyBlack.ignoresSafeArea()
        
        SpotifyCardView()
    }
}
