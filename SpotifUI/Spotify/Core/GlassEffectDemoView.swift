//
//  GlassEffectDemoView.swift
//  SpotifUI
//
//  Created by Niccolò Vianello on 13/06/25.
//


import SwiftUI

#if os(iOS)
struct GlassEffectDemoView: View {
    @State private var iconCount: Int = 1
    @Namespace private var namespace


    var body: some View {
        ZStack {
            Image(systemName: "")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            
            VStack(spacing: 24) {
                GlassEffectContainer(spacing: 40.0) {
                    HStack(spacing: 40.0) {
                        Image(systemName: "sun.max.fill")
                            .frame(width: 80.0, height: 80.0)
                            .font(.system(size: 36))
                            .foregroundStyle(.yellow)
                            .glassEffect()
                            .glassEffectID("sun", in: namespace)


                        if iconCount > 1 {
                            Image(systemName: "moon.fill")
                                .frame(width: 80.0, height: 80.0)
                                .font(.system(size: 36))
                                .foregroundStyle(.gray)
                                .glassEffect()
                                .glassEffectID("moon", in: namespace)
                        }
                        
                        if iconCount > 2 {
                            Image(systemName: "sparkles")
                                .frame(width: 80.0, height: 80.0)
                                .font(.system(size: 36))
                                .foregroundStyle(.purple)
                                .glassEffect()
                                .glassEffectID("sparkles", in: namespace)
                        }
                    }
                }


                Button("Morph") {
                    withAnimation(.bouncy) {
                        iconCount = (iconCount % 3) + 1
                    }
                }
                .buttonStyle(.glass)
            }
        }
    }
}
#endif
