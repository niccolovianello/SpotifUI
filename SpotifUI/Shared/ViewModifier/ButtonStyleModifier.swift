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

struct GlassButtonStyleModifier: ButtonStyle {
    
    var tint: Color? = nil
    var glassStyle: Glass = .regular
    var shape: ButtonBorderShape = .capsule
    var isEnabled: Bool = true
    
    func makeBody(configuration: Configuration) -> some View {
        configuration
            .label
            .glassEffect(glassStyle.interactive().tint(tint), in: shape, isEnabled: isEnabled)
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
    
    func makeGlassButton(tint: Color? = nil, glassStyle: Glass = .regular, shape: ButtonBorderShape = .capsule, isInteractive: Bool = false, isEnabled: Bool = true, action: @escaping () -> Void) -> some View {
        Button {
            action()
        } label: {
            self
        }
        .buttonStyle(GlassButtonStyleModifier(tint: tint, glassStyle: glassStyle, shape: shape, isEnabled: isEnabled))
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
    
    @ViewBuilder
    func makeGlassButton(_ type: ButtonType = .press, tint: Color? = nil, _ action: @escaping () -> Void) -> some View {
        switch type {
        case .tap:
            self.makeGlassButton(tint: tint, shape: .roundedRectangle, action: action)
        case .press, .opacity:
            self.makeGlassButton(tint: tint, action: action)
        }
    }
}
