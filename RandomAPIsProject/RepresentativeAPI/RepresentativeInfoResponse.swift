//
//  RepresentativeInfoResponse.swift
//  RandomAPIsProject
//
//  Created by Wesley Keetch on 12/3/24.
//

import Foundation

struct RepInfoAPI {
  static func fetchRepInfo(zip: String) async -> [RepresentativeModel] {
    let encodedZip = zip.trimmingCharacters(in: .whitespacesAndNewlines)
      .addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? zip
    
    guard let url = URL(string: "https://whoismyrepresentative.com/getall_mems.php?zip=\(encodedZip)&output=json") else {
      print("Invalid URL for zip: \(zip)")
      return []
    }
    
    do {
      print("Starting API call for zip: \(zip)")
      
      let (data, response) = try await URLSession.shared.data(from: url)
      print("API call completed")
      
      if let httpResponse = response as? HTTPURLResponse {
        if httpResponse.statusCode != 200 {
          print("HTTP Error: Status Code \(httpResponse.statusCode)")
          return []
        }
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
