//
//  WeatherSearch.swift
//  WeatherApp
//
//  Created by Priyadarshan Meshram on 27/03/24.
//

import SwiftUI

struct WeatherSearchView: View {
  
  @StateObject var viewModel = WeatherSearchViewModel()
  
  @State var searchString: String = ""
  var body: some View {
    NavigationStack {
      List {
        ForEach(viewModel.list) { info in
          switch info {
          case let .local(value):
            WeatherSearchView()
          case let .search(value):
            CityNameCard(name: value)
          }
        }
        .onDelete(perform: { indexSet in
          
        })
        .deleteDisabled(true)
      }
//      .overlay(content: {
//        ContentUnavailableView(Localization.searchContentEmptyState, systemImage: "cloud.sun.rain.fill")
//          .dynamicTypeSize(.xSmall)
//            .foregroundStyle(.gray)
//            .padding(.bottom, 200)
//      })
      .listStyle(.plain)
      .searchable(text: $searchString, placement: .navigationBarDrawer(displayMode: .always), prompt: Localization.searchCityPlaceholder)
      .navigationTitle(Text("Weather App"))
    }
  }
}

#Preview {
  WeatherSearchView()
}
