//
//  RepresentativeInfoResponse.swift
//  RandomAPIsProject
//
//  Created by Wesley Keetch on 12/3/24.
//

import Foundation

struct RepInfoAPI {
  static func fetchRepInfo(zip: String) async -> [RepresentativeModel] {
    guard let url = URL(string: "https://whoismyrepresentative.com/getall_mems.php?zip=\(zip)&output=json") else {
      print("Invalid URL for zip: \(zip)")
      return []
    }
    do {
      let (data, response) = try await URLSession.shared.data(from: url)
      if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode != 200 {
        print("HTTP Error: Status Code \(httpResponse.statusCode)")
        return []
      }
      if let jsonString = String(data: data, encoding: .utf8) {
        print("Raw JSON response: \(jsonString)")
      }
      let results = try JSONDecoder().decode(RepInfoResults.self, from: data)
      return results.results
    } catch let decodingError as DecodingError {
      print("Decoding Error: \(decodingError)")
    } catch {
      print("Failed to fetch representative info: \(error.localizedDescription)")
    }
    return []
  }
}

