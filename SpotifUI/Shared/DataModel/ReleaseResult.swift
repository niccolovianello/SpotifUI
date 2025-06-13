//
//  Product.swift
//  SwiftUIBoost
//
//  Created by Niccolò Vianello on 28/05/25.
//

import Foundation

struct ReleaseResult: Codable {
    let pagination: Pagination
    let releases: [Release]?
}

struct Pagination: Codable {
    let page, pages, perPage, items: Int
    let urls: URLs
}

struct URLs: Codable {
    let first, last, prev, next: String?
}

struct Release: Codable, Identifiable {
    let id: Int
    let status, type, format, label: String?
    let title: String
    let resourceURL: String?
    let role, artist: String
    let year: Int
    let thumb: String
    
    enum CodingKeys: String, CodingKey {
        case id, status, type, format, label, title
        case resourceURL = "resource_url"
        case role, artist, year, thumb
    }
}

struct ReleaseRow: Identifiable {
    let id = UUID().uuidString
    let title: String
    let releases: [Release]
}

struct Resource: Codable {
    let id: Int
    let status: String
    let year: Int
    let resourceURL, uri: String
    let artists: [Artist]
    let artistsSort: String
    let dataQuality: String
    let formatQuantity: Int
    let dateAdded, dateChanged: Date
    let numForSale: Int
    let lowestPrice: Double
    let title, country, released, releasedFormatted: String
    let genres, styles: [String]
    let tracklist: [Tracklist]
    let extraartists: [Artist]
    let thumb: String
    let estimatedWeight: Int
    let blockedFromSale, isOffensive: Bool
}

// MARK: - Artist
struct Artist: Codable {
    let name, anv, join, role: String
    let tracks: String
    let id: Int
    let resourceURL: String
    let thumbnailURL: String?
    
    enum CodingKeys: String, CodingKey {
        case name, anv, join, role, tracks, id
        case resourceURL = "resource_url"
        case thumbnailURL = "thumbnail_url"
    }
}

struct Tracklist: Codable {
    let position, type, title, duration: String
    
    enum CodingKeys: String, CodingKey {
        case position
        case type = "type_"
        case title, duration
    }
}
