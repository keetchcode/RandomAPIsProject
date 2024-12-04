//
//  DogNetworkManager.swift
//  RandomAPIsProject
//
//  Created by Wesley Keetch on 12/4/24.
//

import Foundation
import UIKit

enum NetworkError: LocalizedError {
  case imageDataMissing
}

struct DogNetworkManager {
  
  static func fetchDogImage() async throws -> UIImage {
    let url = URL(string: "https://dog.ceo/api/breeds/image/random")!
    let (data, response) = try await URLSession.shared.data(from: url)
    let photoResponse = try JSONDecoder().decode(DogModel.self, from: data)
    
    guard photoResponse.status == "success", let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
      throw NetworkError.imageDataMissing
    }
    return try await DogNetworkManager.fetchImage(from: URL(string: photoResponse.message)!)
  }
  
  static func fetchImage(from url: URL) async throws -> UIImage {
    let (data, response) = try await URLSession.shared.data(from: url)
    
    guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200, let image = UIImage(data: data) else {
      throw NetworkError.imageDataMissing
    }
    return image
  }
}
