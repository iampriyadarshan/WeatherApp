//
//  WeatherSearchInjectables.swift
//  WeatherApp
//
//  Created by Priyadarshan Meshram on 28/03/24.
//

import Foundation

private struct WeatherSearchRepositoryKey: InjectionKey {
  static var currentValue: WeatherSearchRepositoryType = WeatherSearchRepository()
}

extension InjectedValues {
  var weatherSearchRepository: WeatherSearchRepositoryType {
    get { Self[WeatherSearchRepositoryKey.self] }
    set { Self[WeatherSearchRepositoryKey.self] = newValue }
  }
}
