//
//  WeatherSearchViewModel.swift
//  WeatherApp
//
//  Created by Priyadarshan Meshram on 27/03/24.
//

import Foundation


enum WeatherResultType: Hashable, Identifiable {
  var id: Self  {
    self
  }
  case local(String)
  case search(String)
}

class WeatherSearchViewModel: ObservableObject {
  
//  @Published var list: [WeatherResultType] = [WeatherResultType]()
  
  @Published var list: [WeatherResultType] = [.search("1"), .search("2")]
  
  
  
}
