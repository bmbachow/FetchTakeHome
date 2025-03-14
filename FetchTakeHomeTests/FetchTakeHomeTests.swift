//
//  FetchTakeHomeTests.swift
//  FetchTakeHomeTests
//
//  Created by Brian Bachow on 3/13/25.
//

import XCTest
@testable import FetchTakeHome

final class FetchTakeHomeTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testFetchRecipesSuccess() async throws {
        let recipeService = RecipeService() // Ensure this matches your actual class
        let recipes = try await recipeService.fetchRecipes()

        XCTAssertFalse(recipes.isEmpty, "Expected recipes but got an empty array")
    }

    func testImageCachingWorks() {
        let imageCache = ImageCacheManager.shared
        let testURL = URL(string: "https://example.com/test.jpg")!
        let testImage = UIImage(systemName: "star")!

        imageCache.cacheImage(testImage, for: testURL)

        let retrievedImage = imageCache.getCachedImage(for: testURL)
        XCTAssertNotNil(retrievedImage, "Cached image should be retrievable")
    }
    
    func testRecipeDecoding() throws {
        let jsonData = """
        {
            "uuid": "12345",
            "name": "Test Recipe",
            "cuisine": "Test Cuisine",
            "photo_url_small": "https://example.com/small.jpg",
            "photo_url_large": "https://example.com/large.jpg",
            "source_url": "https://example.com",
            "youtube_url": "https://youtube.com"
        }
        """.data(using: .utf8)!

        let decodedRecipe = try JSONDecoder().decode(Recipe.self, from: jsonData)

        XCTAssertEqual(decodedRecipe.id, "12345")
        XCTAssertEqual(decodedRecipe.name, "Test Recipe")
        XCTAssertEqual(decodedRecipe.cuisine, "Test Cuisine")
        XCTAssertEqual(decodedRecipe.photoURLSmall, URL(string: "https://example.com/small.jpg"))
    }
}
