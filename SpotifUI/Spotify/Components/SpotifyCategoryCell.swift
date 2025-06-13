//
//  SpotifyCategoryCell.swift
//  SwiftUIBoost
//
//  Created by Niccolò Vianello on 28/05/25.
//

import Foundation
import SwiftUI

struct SpotifyCategoryCell: View {
    
    var title: String = "Category"
    var isSelected: Bool = false
    var expandOnSelect: Bool = false
    var expandedText: String? = nil
    
    @State var isExpansionExpanded: Bool = false
    @State var isExpansionSelected: Bool = false
    
    var body: some View {
        HStack(spacing: -8) {
            Text(title)
                .font(.callout)
                .frame(minWidth: 35)
                .padding(.vertical, 8)
                .padding(.horizontal, 10)
                .themeColors(isSelected: isSelected)
                .onChange(of: isSelected) {
                    isExpansionSelected = false
                    withAnimation(.bouncy) {
                        isExpansionExpanded.toggle()
                    }
                }
            
            if expandOnSelect && isExpansionExpanded {
                if let expandedText = expandedText {
                    Text(expandedText)
                        .font(.callout)
                        .frame(minWidth: 35)
                        .padding(.vertical, 8)
                        .padding(.horizontal, 10)
                        .themeColors(isSelected: isExpansionSelected)
                        .onTapGesture {
                            isExpansionSelected.toggle()
                        }
                }
            }
        }
    }
}

#Preview {
    ZStack {
        Color.spotifyBlack
            .ignoresSafeArea()
        
        HStack {
//            SpotifyCategoryCell()
            SpotifyCategoryCell(isSelected: true, expandOnSelect: true, expandedText: "Expanded")
//            SpotifyCategoryCell()
        }
        .wrapInGlassContainer()
    }
}
