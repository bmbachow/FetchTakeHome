//
//  ImageCacheManager.swift
//  FetchTakeHome
//
//  Created by Brian Bachow on 3/13/25.
//

import Foundation
import UIKit

class ImageCacheManager {
    static let shared = ImageCacheManager()
    private init() {}

    private let cacheDirectory: URL = {
        let paths = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)
        return paths[0].appendingPathComponent("RecipeImageCache")
    }()

    // Generates a unique filename based on the URL
    private func cachedFilePath(for url: URL) -> URL {
        let filename = url.absoluteString.addingPercentEncoding(withAllowedCharacters: .alphanumerics) ?? UUID().uuidString
        return cacheDirectory.appendingPathComponent(filename)
    }

    func getCachedImage(for url: URL) -> UIImage? {
        let filePath = cachedFilePath(for: url)

        if let data = try? Data(contentsOf: filePath), let image = UIImage(data: data) {
            return image
        }
        return nil
    }

    func cacheImage(_ image: UIImage, for url: URL) {
        let filePath = cachedFilePath(for: url)

        // Ensure the directory exists
        try? FileManager.default.createDirectory(at: cacheDirectory, withIntermediateDirectories: true)

        if let data = image.jpegData(compressionQuality: 0.8) {
            try? data.write(to: filePath)
        }
    }
}
