//
//  WeatherSearch.swift
//  WeatherApp
//
//  Created by Priyadarshan Meshram on 28/03/24.
//

import SwiftUI

struct WeatherSearchView: View {
  @Environment(\.modelContext) private var modelContext
  
  @ObservedObject private var viewModel: WeatherSearchViewModel
  
  init(viewModel: WeatherSearchViewModel) {
    self.viewModel = viewModel
  }
  
  var body: some View {
    NavigationStack {
      List {
        ForEach(viewModel.list) { location in
          NavigationLink {
            WeatherDetailsView(viewModel: WeatherDetailsViewModel(modelContext: modelContext, location: location))
          } label: {
            switch location {
            case let .local(localLocation):
              WeatherCityInfoCard(viewModel: localLocation.toWeatherCityInfoCardViewModel)
            case let .search(location):
              CityNameCard(name: location.locationName)
            }
          }
          
        }
        .onDelete(perform: { indexSet in
          viewModel.deleteItem(offsets: indexSet)
        })
        .deleteDisabled(!viewModel.canDelete)
      }
      .overlay(content: {
        switch viewModel.viewState {
        case .data:
          EmptyView()
        case .empty:
          ContentUnavailableView(Localization.searchContentEmptyState, systemImage: "cloud.sun.rain.fill")
            .dynamicTypeSize(.xSmall)
              .foregroundStyle(.gray)
              .padding(.bottom, 200)
        }
      })
      .listStyle(.plain)
      .searchable(text: $viewModel.searchQuery, placement: .navigationBarDrawer(displayMode: .automatic), prompt: Localization.searchCityPlaceholder)
      .navigationTitle(Text("Weather App"))
      .onAppear {
        viewModel.bindSearchQuery()
      }
    }
  }
}

//#Preview {
//  WeatherSearchView(viewModel: WeatherSearchViewModel(modelContext: ))
//}
