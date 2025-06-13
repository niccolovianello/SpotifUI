//
//  SpotifyHomeView.swift
//  SwiftUIBoost
//
//  Created by Niccolò Vianello on 28/05/25.
//

import SwiftUI

@MainActor
@Observable
final class SpotifyHomeViewModel {
    
    @ObservationIgnored private var apiHelper = APIHelper()
    
    var currentUser: User? = nil
    var releases: [Release]? = nil
    var releaseRows: [ReleaseRow]? = []
    
    func getData() async throws {
        
        do {
            currentUser = try await apiHelper.fetchUsers().users?.first
            let releaseResult = try await apiHelper.fetchPage()
            if let releaseResult, let releases = releaseResult.releases {
                self.releases = Array(releases.prefix(8))
                
                var rows: [ReleaseRow] = []
                let allArtists = Set(releases.map( \.artist ))
                for artist in allArtists {
                    rows.append(ReleaseRow(title: artist, releases: releases))
                }
                
                releaseRows = rows
            }
            
        } catch {
            throw APIError.invalidResponse
        }
    }
}

struct SpotifyHomeView: View {
    
    @State private var viewModel = SpotifyHomeViewModel()
    @State private var selectedCategory: CategoryType? = nil
    
    var body: some View {
        ZStack {
#if os(iOS)
            Color.spotifyBlack
                .ignoresSafeArea()
#endif
            
            ScrollView(.vertical) {
                LazyVStack(spacing: 1, pinnedViews: [.sectionHeaders]) {
                    Section {
                        VStack(spacing: 16) {
                            RecentsSectionView(releases: $viewModel.releases)
#if os(iOS)
                                .wrapInGlassContainer()
#endif
                                .padding(.horizontal, 16)
                                
                            if let release = viewModel.releases?.first {
                                newReleaseSection(release: release)
                                    .padding(.horizontal, 16)
                            }
                            
                            if let releaseRows = viewModel.releaseRows {
                                rows(rows: releaseRows)
                            }
                        }
                        
                    } header: {
                        header
                    }
                }
                .padding(.top, 8)
            }
            .scrollIndicators(.hidden)
            .clipped()
            
        }
        .ignoresSafeArea(edges: .bottom)
        .onAppear {
            selectedCategory = CategoryType.allCases.first
        }
        .task {
            try? await viewModel.getData()
        }
        .toolbarVisibility(.hidden, for: .navigationBar)
#if os(visionOS)
        .glassBackgroundEffect()
#endif
    }
    
    private var header: some View {
        HStack(spacing: 0) {
            ZStack(alignment: .leading) {   
                
                ScrollView(.horizontal) {
                    HStack(spacing: 8) {
                        ForEach(CategoryType.allCases, id: \.rawValue) { category in
                            SpotifyCategoryCell(title: category.category.name.capitalized, isSelected: category == selectedCategory, expandOnSelect: category.category.expandOnSelection, expandedText: category.category.expandedCategory)
                                .onTapGesture {
                                    selectedCategory = category
                                }
                        }
                    }
                    .padding(.horizontal, 48)
                }
                .scrollIndicators(.hidden)
                
                ZStack {
                    
                    if let currentUser = viewModel.currentUser,
                       let imageUrl = currentUser.image {
                        ImageLoaderView(url: imageUrl)
                        #if os(iOS)
                            .glassEffect(.regular)
                        #endif
                            .clipShape(Circle())
                            .onTapGesture {
                                
                            }
                            .frame(width: 35, height: 35)
                    }
                }
            }
#if os(iOS)
            .wrapInGlassContainer()
#endif
        }
        .padding(.vertical)
        .padding(.leading)
        
    }
    
    private func newReleaseSection(release: Release) -> some View {
        SpotifyNewReleaseCell(
            headerTitle: release.title,
            headerDescription: release.label,
            detailTitle: release.artist,
            detailDescription: String(release.year)
        )
    }
    
    private func rows(rows: [ReleaseRow]) -> some View {
        ForEach(rows) { row in
            Text(row.title)
                .foregroundStyle(.spotifyWhite)
                .font(.title)
                .fontWeight(.semibold)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 16)
            
            ScrollView(.horizontal) {
                HStack(spacing: 16) {
                    ForEach(row.releases) { release in
                        SpotifyCardView(text: release.title, lineLimit: 1)
                    }
                }
                .padding(.horizontal, 16)
            }
#if os(iOS)
            .wrapInGlassContainer()
#endif
            .scrollIndicators(.hidden)
        }
    }
}

struct RecentsSectionView: View {
    
    @Binding var releases: [Release]?
    
    var body: some View {
        if let releases {
            NonLazyVGrid(columns: 2, alignment: .center, spacing: 8, items: releases) { release in
                if let release {
                    SpotifyRecentsCell(title: release.title)
                }
            }
        }
    }
}

#Preview {
    SpotifyHomeView()
}
