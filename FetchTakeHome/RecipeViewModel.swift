//
//  RecipeViewModel.swift
//  FetchTakeHome
//
//  Created by Brian Bachow on 3/13/25.
//

import Foundation

@MainActor
class RecipeViewModel: ObservableObject {
    @Published var recipes: [Recipe] = [] // Stores fetched recipes
    @Published var isLoading: Bool = false // Tracks loading state
    @Published var errorMessage: String? // Stores error messages for UI

    private let recipeService = RecipeService.shared

    func fetchRecipes() async {
        isLoading = true
        errorMessage = nil // Reset error message before fetching
        
        do {
            let fetchedRecipes = try await recipeService.fetchRecipes()
            recipes = fetchedRecipes
        } catch let error as RecipeError {
            errorMessage = getErrorMessage(error) // Convert error to user-friendly message
        } catch {
            errorMessage = "An unexpected error occurred."
        }

        isLoading = false
    }

    private func getErrorMessage(_ error: RecipeError) -> String {
        switch error {
        case .invalidURL(let url):
            return "Invalid URL: \(url)"
        case .requestFailed(let statusCode):
            return "Request failed with status code: \(statusCode)"
        case .decodingFailed(let errorMessage):
            return "Failed to decode recipes: \(errorMessage)"
        case .emptyData:
            return "No recipes available."
        case .unknown(let error):
            return "An unexpected error occurred: \(error.localizedDescription)"
        }
    }
}
