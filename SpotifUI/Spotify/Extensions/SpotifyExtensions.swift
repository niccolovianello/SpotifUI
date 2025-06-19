//
//  SpotifyExtensions.swift
//  SpotifUI
//
//  Created by Niccolò Vianello on 12/06/25.
//

import Foundation
import SwiftUI

extension View {
    func themeColors(isSelected: Bool, shape: ButtonBorderShape = .capsule) -> some View {
        return self
            .glassEffect(.regular.tint(isSelected ? .spotifyGreen : .clear).interactive(), in: shape)
            .foregroundStyle(isSelected ? .spotifyBlack : .spotifyWhite)
    }
    
    func wrapInGlassContainer(spacing: CGFloat? = nil) -> some View {
   
        return GlassEffectContainer(spacing: spacing) {
            self
        }
    }
}

struct RoundedCornersShape: Shape {
    let corners: UIRectCorner
    let radius: CGFloat
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect,
                                byRoundingCorners: corners,
                                cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}
