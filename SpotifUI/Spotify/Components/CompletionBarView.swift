//
//  CompletionBarView.swift
//  SpotifUI
//
//  Created by Niccolò Vianello on 18/06/25.
//

import SwiftUI

struct CompletionBarView: View {
    
    var completionPercentage: CGFloat = 0.5
    var barColor: Color = .spotifyGreen
    var barheight: CGFloat = 10
    var leadingPadding: CGFloat = 0
    var trailingPadding: CGFloat = 0
    var topPadding: CGFloat = 0
    var bottomPadding: CGFloat = 0
    
    var body: some View {
        GeometryReader { geometry in
            let availableWidth = geometry.size.width
            
            Capsule()
                .frame(width: availableWidth * completionPercentage, height: barheight)
                .foregroundStyle(barColor)
        }
        .frame(maxHeight: barheight)
        .padding(.leading, leadingPadding)
        .padding(.trailing, trailingPadding)
        .padding(.top, topPadding)
        .padding(.bottom, bottomPadding)
    }
}

#Preview {
    ZStack {
        Color.spotifyBlack.ignoresSafeArea()
        
        SpotifyRecentsCell(hasAudioBars: false)
    }
}
