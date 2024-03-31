//
//  WeatherDetailResponse.swift
//  WeatherApp
//
//  Created by Priyadarshan Meshram on 30/03/24.
//

import Foundation
import SwiftData

// MARK: - WeatherDetailsResponse
struct WeatherDetailsResponse: Decodable {
  let location: Location
  let current: Current
  let forecast: Forecast
  let alerts: Alerts
}

// MARK: - Alerts
struct Alerts: Decodable {
  let alert: [Alert]
}

// MARK: - Alert
struct Alert: Decodable {
  let headline: String
  let event: String
  let effective : String
  let expires: String
  let desc: String
}

// MARK: - Current
struct Current: Decodable {
  let tempC: Double
  let isDay: Int
  let condition: Condition
  let windKph: Double
  let windDir: String
  let precipMm: Double
  let feelslikeC: Double
  let uv: Double

  enum CodingKeys: String, CodingKey {
    case tempC = "temp_c"
    case isDay = "is_day"
    case condition
    case windKph = "wind_kph"
    case windDir = "wind_dir"
    case precipMm = "precip_mm"
    case feelslikeC = "feelslike_c"
    case uv
  }
}

// MARK: - Condition
struct Condition: Decodable {
  let code: Int
}

// MARK: - Forecast
struct Forecast: Decodable {
  let forecastday: [Forecastday]
}

// MARK: - Forecastday
struct Forecastday: Decodable {
  let date: String
  let dateEpoch: Int
  let day: Day
  let astro: Astro
  
  enum CodingKeys: String, CodingKey {
    case date
    case dateEpoch = "date_epoch"
    case day
    case astro
  }
}

// MARK: - Astro
struct Astro: Decodable {
  let sunrise: String
  let sunset: String
}

// MARK: - Day
struct Day: Decodable {
  let maxtempC: Double
  let mintempC: Double
  let condition: Condition
  
  enum CodingKeys: String, CodingKey {
    case maxtempC = "maxtemp_c"
    case mintempC = "mintemp_c"
    case condition
  }
}


// MARK: - Location
struct Location: Decodable {
  let name: String
  let region: String
  let country: String
  let lat: Double
  let lon: Double
}

