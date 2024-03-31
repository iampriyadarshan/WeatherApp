//
//  FutureForecastGroupView.swift
//  WeatherApp
//
//  Created by Priyadarshan Meshram on 28/03/24.
//

import SwiftUI



struct FutureForecastGroupView: View {
  
  let forecastList: [FutureForecastInfoViewModel]
  
  init(forecastList: [FutureForecastInfoViewModel]) {
    self.forecastList = forecastList
  }
  
  var body: some View {
    GroupBox(
      label:
        HStack {
          Image(systemName: "calendar")
          Text("\(forecastList.count)-day forecast")
            .font(.subheadline)
            .fontWeight(.semibold)
          Spacer()
        }
    ) {
      ForEach(forecastList) { info in
        Divider().padding(.vertical, 0)
        HStack(spacing: 4) {
          Text(info.date)
          Spacer()
          Image("day/\(info.imageCode)")
            .resizable()
            .frame(width: 25, height: 25)
            .padding(.horizontal)
          
          Image(systemName: "arrow.up")
          
          Text("\(String(format: "%.1f", info.maxTemp))°c")
            .padding(.trailing, 8)
          Image(systemName: "arrow.down")
          Text("\(String(format: "%.1f", info.minTemp))°c")
        }
        .font(.subheadline)
      }
    }
    .backgroundStyle(.grayBackground)
  }
}

#Preview {
  FutureForecastGroupView(forecastList: [])
}
