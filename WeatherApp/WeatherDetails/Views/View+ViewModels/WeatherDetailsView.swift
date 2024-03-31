//
//  WeatherDetailsView.swift
//  WeatherApp
//
//  Created by Priyadarshan Meshram on 28/03/24.
//

import SwiftUI

struct WeatherDetailsView: View {
  
  
  @ObservedObject private var viewModel: WeatherDetailsViewModel
  
  init(viewModel: WeatherDetailsViewModel) {
    self.viewModel = viewModel
  }
  
  var body: some View {
    ScrollView {
      switch viewModel.viewState {
      case .empty:
        EmptyView()
      case .loading:
        ProgressView()
      case .error:
        ContentUnavailableView.search
      case let .data( weatherDetails):
        getDetailView(details: weatherDetails)
      }
    }
    .navigationBarTitleDisplayMode(.inline)
    .onAppear {
      viewModel.getWeatherDetails()
    }
  }
  
  private func getDetailView(details: WeatherDetails) -> some View {
    VStack {
      HeaderView(viewModel: details.headerInfo)
        .padding(.horizontal)
      
      FutureForecastGroupView(forecastList: details.forecastList)
        .padding()
      
      LazyVGrid(columns: [GridItem(.flexible()),GridItem(.flexible())]) {
        PrecipitationInfoView(viewModel: details.precipitationInfo)
        WindInfoView(viewModel: details.windInfo)
        UVIndexInfoView(viewModel: details.uvIndexInfo)
        SunSetRiseInfoView(viewModel: details.sunSetRiseInfo)
      }
      .padding(.horizontal)
      
      if !details.alertsInfo.isEmpty {
        Section(content: {
          
          ForEach(details.alertsInfo) { alert in
            AlertInfoView(viewModel: alert)
          }
        }, header: {
          HStack {
            Image(systemName: "bell")
            Text("Alerts")
            Spacer()
          }
          .padding(.top)
        })
        .padding(.horizontal)
      }
    }
    .toolbar(content: {
      ToolbarItem {
        Button(action: {
          viewModel.saveRemoveButtonClicked()
        }, label: {
          HStack {
            Image(systemName: viewModel.addRemoveButtonState == .add ? "plus" : "trash")
            Text(viewModel.addRemoveButtonState == .add ? "Add" : "Remove")
          }
          .font(.footnote)
          .foregroundStyle(viewModel.addRemoveButtonState == .add ? .black : .red)
        })
      }
    })
  }
}

//#Preview {
//  WeatherDetailsView(viewModel: WeatherDetailsViewModel(modelContext: , location: ))
//}
