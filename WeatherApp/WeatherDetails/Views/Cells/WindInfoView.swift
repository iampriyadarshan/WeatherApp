//
//  WindInfoView.swift
//  WeatherApp
//
//  Created by Priyadarshan Meshram on 29/03/24.
//

import SwiftUI


struct WindInfoView: View {
  
  let viewModel: WindInfoViewModel
  
  init(viewModel: WindInfoViewModel) {
    self.viewModel = viewModel
  }
  
  var body: some View {
    GroupBox {
      HStack {
        VStack(alignment: .leading) {
          HStack {
            Image(systemName: "wind")
              .frame(width: 14, height: 14)
            Text("Wind")
          }
          Text(viewModel.windSpeed)
            .font(.headline)
        }
        Spacer()
        Text(viewModel.windDirection)
          .lineLimit(1)
          .minimumScaleFactor(0.5)
          .font(.title2)
          .fontWeight(.bold)
      }
    }
    .backgroundStyle(.currentDayInfo)
  }
}

#Preview {
  WindInfoView(viewModel: WindInfoViewModel(windSpeed: "29.5 kph", windDirection: "N"))
}
