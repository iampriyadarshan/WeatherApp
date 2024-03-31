//
//  WeatherDetailInjectables.swift
//  WeatherApp
//
//  Created by Priyadarshan Meshram on 30/03/24.
//

import Foundation

private struct WeatherDetailRepositoryKey: InjectionKey {
  static var currentValue: WeatherDetailsRepositoryType = WeatherDetailsRepository()
}

extension InjectedValues {
  var weatherDetailRepository: WeatherDetailsRepositoryType {
    get { Self[WeatherDetailRepositoryKey.self] }
    set { Self[WeatherDetailRepositoryKey.self] = newValue }
  }
}
