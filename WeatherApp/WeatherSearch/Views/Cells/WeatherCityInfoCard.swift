//
//  WeatherCityInfo.swift
//  WeatherApp
//
//  Created by Priyadarshan Meshram on 27/03/24.
//

import SwiftUI

struct WeatherCityInfoCard: View {
    var body: some View {
      HStack {
        VStack(alignment: .leading) {
          Text("City Name")
            .font(.title2)
          Text("Sub, Location")
            .font(.footnote)
        }
        Spacer()
        VStack(alignment: .trailing) {
          HStack {
            Text("19°c")
              .font(.title2)
            Image(systemName: "cloud.rain")
          }
          Text("12:00 am")
            .foregroundStyle(.gray)
            .font(.footnote)
        }
      }
    }
}

#Preview {
    WeatherCityInfoCard()
}
