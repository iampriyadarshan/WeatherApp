//
//  WeatherSearchRepository.swift
//  WeatherApp
//
//  Created by Priyadarshan Meshram on 28/03/24.
//

import Foundation
import Jaal
import Combine


protocol WeatherSearchRepositoryType {
  func getWeatherList(
    for query: String
  ) -> AnyPublisher<[WeatherLocation], JaalError>
}

struct WeatherSearchRepository: WeatherSearchRepositoryType {
  private let network = JaalProvider<WeatherSearchTarget>()
  
  func getWeatherList(for query: String) -> AnyPublisher<[WeatherLocation], JaalError> {
    network.request(
      target: .search(for: query),
      scheduler: DispatchQueue.main,
      type: [WeatherLocation].self
    )
  }
  
}


enum WeatherSearchTarget: TargetType {
  
  case search(for: String)
  
  var path: String {
    switch self {
    case .search:
      "/search.json"
    }
  }
  
  var method: HTTPMethod {
    .get
  }
  
  var task: HTTPTaskType {
    switch self {
    case let .search(for: q):
        .requestParameters(parameters: ["q" : q].merging(AppNetworkConstantsProvider.shared.apiKey) { $1 })
    }
  }
  
  var headers: [String : String]? {
    nil
  }
}

