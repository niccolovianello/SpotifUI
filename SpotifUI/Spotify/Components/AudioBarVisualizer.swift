//
//  AudioBarVisualizer.swift
//  SpotifUI
//
//  Created by Niccolò Vianello on 18/06/25.
//


import SwiftUI

struct AudioBarVisualizer: View {
    let barCount: Int
    let animationSpeed: Double // in seconds
    let color: Color = .spotifyGreen

    @State private var barHeights: [CGFloat] = []

    private let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()

    init(barCount: Int = 3, animationSpeed: Double = 0.5) {
        self.barCount = barCount
        self.animationSpeed = animationSpeed
        self._barHeights = State(initialValue: Array(repeating: .zero, count: barCount))
    }
    
    var body: some View {
        GeometryReader { geometry in
            let availableHeight = geometry.size.height
            let availableWidth = geometry.size.width
            let spacing: CGFloat = 2
            
            HStack(alignment: .bottom, spacing: spacing) {
                ForEach(0..<barCount, id: \.self) { index in
                    Capsule()
                        .fill(color)
                        .frame(height: barHeights[index])
                }
                .frame(width: (availableWidth / CGFloat(barCount) - CGFloat(barCount - 1) * spacing))
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
            .onAppear {
                updateBars(maxHeight: availableHeight)
            }
            .onReceive(timer) { _ in
                withAnimation(.easeInOut(duration: animationSpeed)) {
                    updateBars(maxHeight: availableHeight)
                }
            }
        }
    }
    
    private func updateBars(minHeight: CGFloat = 0, maxHeight: CGFloat = 100) {
        barHeights = (0..<barCount).map { _ in
            CGFloat.random(in: minHeight...maxHeight)
        }
    }
}

#Preview {
    AudioBarVisualizer()
}
