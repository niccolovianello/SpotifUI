//
//  ButtonStyleModifier.swift
//  SwiftUIBoost
//
//  Created by Niccolò Vianello on 04/06/25.
//

import SwiftUI

struct ButtonStyleModifier: ButtonStyle {
    
    var scale: CGFloat
    var opacity: CGFloat
    var brightness: CGFloat
    
    func makeBody(configuration: Configuration) -> some View {
        configuration
            .label
            .scaleEffect(configuration.isPressed ? scale : 1)
            .opacity(configuration.isPressed ? opacity : 1)
            .brightness(configuration.isPressed ? brightness : 0)
    }
}

public enum ButtonType {
    case press, tap, opacity
}

public extension View {
    
    func makeButton(scale: CGFloat = 1, opacity: CGFloat = 1, brightness: CGFloat = 0, action: @escaping () -> Void) -> some View {
        Button {
            action()
        } label: {
            self
        }
        .buttonStyle(ButtonStyleModifier(scale: scale, opacity: opacity, brightness: brightness))

    }
    
    @ViewBuilder
    func makeButton(_ type: ButtonType = .tap, action: @escaping () -> Void) -> some View {
        switch type {
        case .press:
            self.makeButton(scale: 0.98, action: action)
        case .tap:
            self.makeButton(brightness: 0.025, action: action)
        case .opacity:
            self.makeButton(opacity: 0.85, action: action)
        }
    }
}
