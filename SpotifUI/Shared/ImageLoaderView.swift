//
//  ImageLoaderView.swift
//  SwiftUIBoost
//
//  Created by Niccolò Vianello on 28/05/25.
//

import SwiftUI

struct ImageLoaderView: View {
    
    var urlString: String? = Constants.randomImageURL
    var resizingMode = ContentMode.fill
    var cornerRadius: CGFloat = 0

    var body: some View {
        Rectangle()
            .opacity(0.0)
            .overlay {
                if let urlString {
                    AsyncImage(url: URL(string: urlString)) { phase in
                        switch phase {
                        case .empty:
                            EmptyView()
                        case .success(let image):
                            image
                                .resizable()
                                .aspectRatio(contentMode: resizingMode)
                                .allowsHitTesting(false)
                                .cornerRadius(cornerRadius)
                        case .failure:
                            EmptyView()
                        @unknown default:
                            EmptyView()
                        }
                    }
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
