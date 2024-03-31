//
//  HeaderView.swift
//  WeatherApp
//
//  Created by Priyadarshan Meshram on 28/03/24.
//

import SwiftUI


struct HeaderView: View {
  private let viewModel: WeatherHeaderInfoViewModel
  
  init(viewModel: WeatherHeaderInfoViewModel) {
    self.viewModel = viewModel
  }
  
  var body: some View {
    VStack {
      HStack {
        VStack(alignment: .leading,spacing: 5) {
          Text(viewModel.locationName)
            .font(.largeTitle)
          Text(viewModel.locationAreaAndReagin)
            .font(.subheadline)
        }
        Spacer()
      }
      
      HStack {
        VStack(alignment: .leading) {
          Spacer()
          HStack(alignment: .top) {
            Text(String(format: "%.0f", viewModel.temperature))
              .font(.system(size: 120))
              .fontWeight(.bold)
            
            Text("°c")
              .font(.system(size: 40))
              .fontWeight(.regular)
              .padding(.top, 16)
          }
          
          HStack(spacing: 4) {
            Image(systemName: "arrow.up")
            
            Text("\(String(format: "%.1f", viewModel.dayMaxTemp))°c")
              .padding(.trailing, 8)
            Image(systemName: "arrow.down")
            Text("\(String(format: "%.2f", viewModel.dayMinTemp))°c")
          }
          .font(.subheadline)
        }
        
        Spacer()
        
        VStack(alignment: .trailing) {
          Spacer()
          Image("\(viewModel.isDay ? "day" : "night")/\(viewModel.imageCode)")
            .frame(width: 64, height: 64)
          Text("feels like \(String(format: "%.1f", viewModel.feelsLikeTemp))°c")
            .font(.subheadline)
        }
      }
    }
    
  }
}

#Preview {
  HeaderView(viewModel: WeatherHeaderInfoViewModel(locationName: "Nagpur", locationAreaAndReagin: "Maharashtra, India", temperature: 30, dayMaxTemp: 30, dayMinTemp: 25, isDay: true, imageCode: "116", feelsLikeTemp: 35))
}
