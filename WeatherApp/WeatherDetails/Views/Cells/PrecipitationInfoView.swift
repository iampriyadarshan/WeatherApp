//
//  PrecipitationView.swift
//  WeatherApp
//
//  Created by Priyadarshan Meshram on 29/03/24.
//

import SwiftUI


struct PrecipitationInfoView: View {
  
  let viewModel: PrecipitationInfoViewModel
  
  init(viewModel: PrecipitationInfoViewModel) {
    self.viewModel = viewModel
  }
  
  var body: some View {
    GroupBox {
      HStack {
        VStack(alignment: .leading) {
          HStack {
            Image(systemName: "cloud.rain")
              .frame(width: 14, height: 14)
            Text("Precipitation")
          }
          Text(viewModel.precipitationValue)
            .font(.headline)
        }
        Spacer()
      }
    }
    .backgroundStyle(.currentDayInfo)
  }
}

#Preview {
  PrecipitationInfoView(viewModel: PrecipitationInfoViewModel(precipitationValue: "1.8 mm"))
}
