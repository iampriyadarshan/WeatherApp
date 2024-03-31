//
//  CityNameCard.swift
//  WeatherApp
//
//  Created by Priyadarshan Meshram on 27/03/24.
//

import SwiftUI

struct CityNameCard: View {
  private let name: String
  
  init(name: String) {
    self.name = name
  }
  
  
  var body: some View {
    Text(name)
  }
}

#Preview {
  CityNameCard(name: "City name")
}
