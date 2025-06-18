//
//  SongRowCell.swift
//  SpotifUI
//
//  Created by Niccolò Vianello on 18/06/25.
//

import SwiftUI

struct SongRowCell: View {
    
    var imageSize: CGFloat = 50
    var imageName: String = Constants.randomImageURL
    var title: String = "Title"
    var artist: String = "Artist"
    
    var onRowTapped: (() -> Void)?
    var onEllipsisTapped: (() -> Void)?
    
    var body: some View {
        HStack {
            ImageLoaderView(urlString: imageName)
                .frame(width: imageSize, height: imageSize)
            
            VStack(alignment: .leading) {
                Text(title)
                    .foregroundStyle(.spotifyWhite)
                    .fontWeight(.semibold)
                
                Text(artist)
                    .foregroundStyle(.spotifyLightGray)
                    .font(.caption)
            }
            .lineLimit(2)
            
            Spacer()
            
            Image(systemName: "ellipsis")
                .font(.subheadline)
                .foregroundStyle(.spotifyLightGray)
                .padding(16)
                .background(.black.opacity(0.001))
                .onTapGesture {
                    onEllipsisTapped?()
                }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    ZStack {
        Color.spotifyBlack.ignoresSafeArea()
        
        VStack {
            SongRowCell()
            SongRowCell()
            SongRowCell()
            SongRowCell()
        }
    }
}
