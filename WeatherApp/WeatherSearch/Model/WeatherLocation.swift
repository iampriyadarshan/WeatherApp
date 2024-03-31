//
//  WeatherLocation.swift
//  WeatherApp
//
//  Created by Priyadarshan Meshram on 28/03/24.
//

import Foundation
import SwiftData

struct WeatherLocation: Codable, Hashable {
  let id: Int
  let name, region, country: String
  let lat, lon: Double
  let url: String
}


extension WeatherLocation {
  var locationName: String {
    "\(name), \(region), \(country)"
  }
  
  var latAndLong: String {
    "\(lat),\(lon)"
  }
}

