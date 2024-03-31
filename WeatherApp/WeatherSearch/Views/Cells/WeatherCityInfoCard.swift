//
//  WeatherCityInfo.swift
//  WeatherApp
//
//  Created by Priyadarshan Meshram on 28/03/24.
//

import SwiftUI


struct WeatherCityInfoCardViewModel {
  let name: String
  let areaRegion: String
  let temp: Double
  let imageCode: String
  let time: String
}

struct WeatherCityInfoCard: View {
  
  let viewModel: WeatherCityInfoCardViewModel
  
  init(viewModel: WeatherCityInfoCardViewModel) {
    self.viewModel = viewModel
  }
  var body: some View {
    HStack {
      VStack(alignment: .leading) {
        Text(viewModel.name)
          .font(.title2)
        Text(viewModel.areaRegion)
          .font(.footnote)
      }
      Spacer()
      VStack(alignment: .trailing) {
        HStack {
          Text("\(String(format: "%.1f", viewModel.temp))°c")
            .font(.title2)
          Image("day/\(viewModel.imageCode)")
            .resizable()
            .frame(width: 45, height: 45)
        }
        Text(viewModel.time)
          .foregroundStyle(.gray)
          .font(.footnote)
      }
    }
  }
}

#Preview {
  WeatherCityInfoCard(viewModel: WeatherCityInfoCardViewModel(name: "Name", areaRegion: "India", temp: 19.0, imageCode: "116", time: "12 am"))
}
