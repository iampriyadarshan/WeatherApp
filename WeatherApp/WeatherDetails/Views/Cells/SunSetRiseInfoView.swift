//
//  SunSetRiseInfoView.swift
//  WeatherApp
//
//  Created by Priyadarshan Meshram on 29/03/24.
//

import SwiftUI


struct SunSetRiseInfoView: View {
  
  let viewModel: SunSetRiseInfoViewModel
  
  init(viewModel: SunSetRiseInfoViewModel) {
    self.viewModel = viewModel
  }
  
  var body: some View {
    GroupBox {
      HStack {
        VStack(alignment: .leading) {
            HStack {
              Image(systemName: "sun.min")
                .frame(width: 14, height: 14)
              Text("Sun")
            }
            HStack(spacing: 4) {
              Image(systemName: "sunrise")
              Text(viewModel.sunriseTime)
                
              Image(systemName: "sunset")
              Text(viewModel.sunsetTime)
            }
            .lineLimit(1)
            .font(.subheadline)
            .minimumScaleFactor(0.6)
        }
        Spacer()
      }
    }
    .backgroundStyle(.currentDayInfo)
  }
}

#Preview {
  SunSetRiseInfoView(viewModel: SunSetRiseInfoViewModel(sunriseTime: "12:12 am", sunsetTime: "21:12 am"))
}
