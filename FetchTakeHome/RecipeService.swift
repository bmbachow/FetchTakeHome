//
//  RecipeService.swift
//  FetchTakeHome
//
//  Created by Brian Bachow on 3/13/25.
//

import Foundation

// Define detailed errors with associated values
enum RecipeError: Error {
    case invalidURL(String) // Provides the invalid URL
    case requestFailed(statusCode: Int) // HTTP status code
    case decodingFailed(error: String) // Error message from JSON decoding
    case emptyData
    case unknown(Error) // Any other error
}

// Service responsible for fetching recipes
class RecipeService {
    static let shared = RecipeService()
    internal init() {}

    internal let recipesURLString = "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json"

    func fetchRecipes() async throws -> [Recipe] {
        // Safely unwrap the URL
        guard let recipesURL = URL(string: recipesURLString) else {
            throw RecipeError.invalidURL(recipesURLString)
        }

        do {
            let (data, response) = try await URLSession.shared.data(from: recipesURL)

            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                throw RecipeError.requestFailed(statusCode: (response as? HTTPURLResponse)?.statusCode ?? -1)
            }

            do {
                let decodedResponse = try JSONDecoder().decode(RecipesData.self, from: data)

                if decodedResponse.recipes.isEmpty {
                    throw RecipeError.emptyData
                }

                return decodedResponse.recipes
            } catch {
                throw RecipeError.decodingFailed(error: error.localizedDescription)
            }

        } catch let error as RecipeError {
            throw error
        } catch {
            throw RecipeError.unknown(error)
        }
    }
}
