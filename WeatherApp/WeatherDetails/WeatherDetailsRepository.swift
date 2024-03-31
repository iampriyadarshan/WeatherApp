//
//  WeatherDetailsRepository.swift
//  WeatherApp
//
//  Created by Priyadarshan Meshram on 30/03/24.
//

import Foundation
import Jaal
import Combine


protocol WeatherDetailsRepositoryType {
  func getWeatherDetail(query: String, days: Int, hour: Int) -> AnyPublisher<WeatherDetailsResponse, JaalError>
}

struct WeatherDetailsRepository: WeatherDetailsRepositoryType {
  private let network = JaalProvider<WeatherDetailTarget>()
  
  func getWeatherDetail(query: String, days: Int, hour: Int) -> AnyPublisher<WeatherDetailsResponse, JaalError> {
    network.request(
      target: .forecast(for: query, days: "\(days)", hour: "\(hour)"),
      scheduler: DispatchQueue.main,
      type: WeatherDetailsResponse.self
    )
  }
  
}


enum WeatherDetailTarget: TargetType {
  
  case forecast(for: String, days: String, hour : String)
  
  
  var path: String {
    switch self {
    case .forecast:
      "/forecast.json"
    }
  }
  
  var method: HTTPMethod {
    .get
  }
  
  var task: HTTPTaskType {
    switch self {
    case let .forecast(for: q, days: day, hour: hour):
        .requestParameters(parameters: ["q": q,
                                        "days": day,
                                        "hour": hour,
                                        "alerts": "yes",
                                        "aqi": "yes"].merging(AppNetworkConstantsProvider.shared.apiKey) { $1 })
    }
  }
  
  var headers: [String : String]? {
    nil
  }
}


