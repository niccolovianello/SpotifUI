//
//  SpotifyAudioBars.swift
//  SwiftUIBoost
//
//  Created by Niccolò Vianello on 29/05/25.
//

import SwiftUI
import PureSwiftUIDesign

struct AudioBars: View {
    
    @State var animating: Bool = false
    var color: Color = .spotifyGreen
    var numBars: Int = 9
    var spacerWidthRatio: CGFloat = 0.2
    
    var body: some View {
        GeometryReader { (geo: GeometryProxy) in
            let barWidthScaleFactor = 1 / (CGFloat(numBars) + CGFloat((numBars - 1)) * spacerWidthRatio)
            let barWidth = geo.widthScaled(barWidthScaleFactor)
            let spacerWidth = barWidth * spacerWidthRatio
            HStack(spacing: spacerWidth) {
                ForEach(0..<numBars, id: \.self) { index in
                    Bar(minHeightFraction: 0.025, maxHeightFraction: 1, completion: animating ? 1 : 0)
                        .fill(color)
                        .frame(width: barWidth)
                        .animation(createAnimation(), value: animating)
                }
            }
        }
    }
    
    private func createAnimation() -> Animation {
        Animation
            .easeInOut(duration: 0.3 + Double.random(in: -0.1...0.1))
            .repeatForever(autoreverses: true)
            .delay(1 + Double.random(in: 0...0.75))
    }
    
}

struct Bar: Shape {
    private let minHeightFraction: CGFloat
    private let maxHeightFraction: CGFloat
    var animatableData: CGFloat
    
    init(minHeightFraction: CGFloat, maxHeightFraction: CGFloat, completion: CGFloat) {
        self.minHeightFraction = minHeightFraction
        self.maxHeightFraction = maxHeightFraction
        self.animatableData = completion
    }
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let heightFraction = minHeightFraction.to(maxHeightFraction, animatableData)
        
        path.rect(rect.scaled(.size(1, heightFraction), at: rect.bottom, anchor: .bottom))
        
        return path
    }
}

#Preview {
    ZStack {
        Color.spotifyBlack.ignoresSafeArea()
        AudioBars(animating: true, numBars: 3, spacerWidthRatio: 0.25)
    }
}
