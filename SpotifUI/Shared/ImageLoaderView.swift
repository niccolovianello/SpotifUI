//
//  ImageLoaderView.swift
//  SwiftUIBoost
//
//  Created by Niccolò Vianello on 28/05/25.
//

import SwiftUI
import SDWebImageSwiftUI

struct ImageLoaderView: View {
    
    var url: String? = Constants.randomImageURL
    var resizingMode = ContentMode.fill

    var body: some View {
        Rectangle()
            .opacity(0.0)
            .overlay {
                if let url {
                    WebImage(url: URL(string: url))
                        .resizable()
                        .indicator(.activity)
                        .aspectRatio(contentMode: resizingMode)
                        .allowsHitTesting(false)
                        .background(Color.spotifyWhite)
                    
//                    AsyncImage(url: URL(string: url)) { phase in
//                        switch phase {
//                        case .empty:
//                            EmptyView()
//                        case .success(let image):
//                            image
//                                .resizable()
//                                .aspectRatio(contentMode: resizingMode)
//                        case .failure:
//                            EmptyView()
//                        @unknown default:
//                            EmptyView()
//                        }
//                    }
                }
            }
            .clipped()
    }
}

#Preview {
    ImageLoaderView()
        .cornerRadius(30)
        .padding(40)
        .padding(.vertical, 60)
        
}
