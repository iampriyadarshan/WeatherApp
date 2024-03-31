//
//  UVIndexInfoView.swift
//  WeatherApp
//
//  Created by Priyadarshan Meshram on 29/03/24.
//

import SwiftUI


struct UVIndexInfoView: View {
  let viewModel: UVIndexInfoViewModel
  
  init(viewModel: UVIndexInfoViewModel) {
    self.viewModel = viewModel
  }
  
  var body: some View {
    GroupBox {
      HStack {
        VStack(alignment: .leading) {
          HStack {
            Image(systemName: "sun.min")
              .frame(width: 14, height: 14)
            Text("UV Index")
          }
          Text(viewModel.indexValue)
            .font(.headline)
        }
        Spacer()
      }
    }
    .backgroundStyle(.currentDayInfo)
  }
}

#Preview {
  UVIndexInfoView(viewModel: UVIndexInfoViewModel(indexValue: "6.0"))
}
