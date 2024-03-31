//
//  Localization.swift
//  WeatherApp
//
//  Created by Priyadarshan Meshram on 28/03/24.
//

import Foundation


enum Localization {
  static let searchCityPlaceholder = "City, Region or US/UK zip code"
  static let searchContentEmptyState = "Search for a city or US/UK zip to check the weather"
}



struct WeatherCondition: Decodable {
  let code : Int
  let day: String
  let night: String
  let icon: Int
}

  
//TODO: Move this to utilites
enum WeatherConditionIcon {
  static func getImageIcon(code: Int) -> Int {
    guard let jsonData = weatherConditionJson.data(using: .utf8) else {
      fatalError("Failed to convert JSON string to data")
    }
    do {
      // Decode JSON data into a Person object
      let weatherConditions = try JSONDecoder().decode([WeatherCondition].self, from: jsonData)
      return weatherConditions.filter { $0.code == code }.first?.icon ?? 113
    } catch {
      print("Error decoding JSON string: \(error)")
      return 113
    }
  }
}
