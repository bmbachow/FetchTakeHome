//
//  RecipeListView.swift
//  FetchTakeHome
//
//  Created by Brian Bachow on 3/13/25.
//


import SwiftUI

struct RecipeListView: View {
    @StateObject private var viewModel = RecipeViewModel()

    var body: some View {
        NavigationView {
            VStack {
                if viewModel.isLoading {
                    ProgressView("Loading Recipes...") // Show loading indicator
                        .padding()
                } else if let errorMessage = viewModel.errorMessage {
                    // Show error message
                    VStack {
                        Text(errorMessage)
                            .foregroundColor(.red)
                            .multilineTextAlignment(.center)
                            .padding()
                        Button("Retry") {
                            Task {
                                await viewModel.fetchRecipes()
                            }
                        }
                        .padding()
                    }
                } else {
                    // Display recipe list
                    List(viewModel.recipes) { recipe in
                        RecipeRowView(recipe: recipe)
                    }
                    .refreshable {
                        await viewModel.fetchRecipes() // Pull-to-refresh support
                    }
                }
            }
            .navigationTitle("Recipes")
            .task {
                await viewModel.fetchRecipes() // Fetch recipes when the view appears
            }
        }
    }
}

// Subview for displaying each recipe in the list
struct RecipeRowView: View {
    let recipe: Recipe
    @State private var image: UIImage?

    var body: some View {
        HStack {
            if let image = image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)
                    .cornerRadius(8)
            } else {
                ProgressView()
                    .frame(width: 50, height: 50)
                    .task {
                        await loadImage()
                    }
            }

            Text(recipe.name)
                .font(.headline)
            Spacer()
            Text(recipe.cuisine)
                .font(.subheadline)
                .foregroundColor(.gray)
        }
        .padding(.vertical, 4)
    }

    private func loadImage() async {
        guard let url = recipe.photoURLSmall else { return }

        // Check if image exists in cache
        if let cachedImage = ImageCacheManager.shared.getCachedImage(for: url) {
            image = cachedImage
            return
        }

        // Download the image if not cached
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            if let downloadedImage = UIImage(data: data) {
                image = downloadedImage
                ImageCacheManager.shared.cacheImage(downloadedImage, for: url)
            }
        } catch {
            print("Failed to load image: \(error)")
        }
    }
}
