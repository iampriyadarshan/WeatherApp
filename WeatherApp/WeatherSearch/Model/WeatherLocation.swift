//
//  WeatherLocation.swift
//  WeatherApp
//
//  Created by Priyadarshan Meshram on 27/03/24.
//

import Foundation

struct WeatherLocation: Codable {
    let id: Int
    let name, region, country: String
    let lat, lon: Double
    let url: String
}
