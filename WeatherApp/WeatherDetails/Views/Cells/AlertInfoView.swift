//
//  AlertInfoView.swift
//  WeatherApp
//
//  Created by Priyadarshan Meshram on 30/03/24.
//

import SwiftUI


struct AlertInfoView: View {
  
  let viewModel: AlertInfoViewModel
  
  init(viewModel: AlertInfoViewModel) {
    self.viewModel = viewModel
  }
  
  var body: some View {
    GroupBox {
      HStack(spacing: 0) {
        Spacer()
        Text(viewModel.event)
          .font(.footnote)
          .padding(6)
          .foregroundStyle(.white)
          .background(.tagOrange)
          .clipShape(.rect(cornerRadius: 6, style: .circular))
      }
      
      HStack {
        VStack(alignment: .leading) {
          Text(viewModel.headline)
            .font(.headline)
            .fontWeight(.bold)
          Text(viewModel.effectiveToExpiresDate)
            .font(.footnote)
        }
        Spacer()
      }
      .padding(.bottom)
      
      Text(viewModel.alertDescription)
    }
    .backgroundStyle(.currentDayInfo)
  }
}

#Preview {
  AlertInfoView(viewModel: AlertInfoViewModel(id: UUID(), headline: "What is Lorem Ipsum?", event: "Lorem Ipsum", effectiveToExpiresDate: "21 Jul, 2023 8:00 pm - 29 Jul, 2023 9:00 pm", alertDescription: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."))
}
