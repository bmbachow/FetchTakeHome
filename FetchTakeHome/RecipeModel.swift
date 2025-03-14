//
//  RecipeModel.swift
//  FetchTakeHome
//
//  Created by Brian Bachow on 3/13/25.
//

import Foundation

struct Recipe: Identifiable, Codable {
    let id: String
    let name: String
    let cuisine: String
    let photoURLSmall: URL?
    let photoURLLarge: URL?
    let sourceURL: URL?
    let youtubeURL: URL?

    enum CodingKeys: String, CodingKey {
        case id = "uuid"
        case name
        case cuisine
        case photoURLSmall = "photo_url_small"
        case photoURLLarge = "photo_url_large"
        case sourceURL = "source_url"
        case youtubeURL = "youtube_url"
    }
}

struct RecipesData: Codable {
    let recipes: [Recipe]
}
