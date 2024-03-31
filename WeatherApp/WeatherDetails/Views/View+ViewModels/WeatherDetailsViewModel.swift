//
//  WeatherDetailsViewModel.swift
//  WeatherApp
//
//  Created by Priyadarshan Meshram on 30/03/24.
//

import Foundation
import SwiftData
import Combine
import Jaal


enum WeatherDetailsViewState {
  case empty
  case loading
  case error(String)
  case data(WeatherDetails)
}

enum AddRemoveButtonState {
  case add
  case remove
}

class WeatherDetailsViewModel: ObservableObject {
  
  @Injected(\.weatherDetailRepository) private var repository: WeatherDetailsRepositoryType
  @Published var viewState: WeatherDetailsViewState = .empty
  @Published var addRemoveButtonState: AddRemoveButtonState = .add
  
  private var cancellables = Set<AnyCancellable>()

  private let modelContext: ModelContext
  private let location: WeatherResultType
  private var localData: WeatherDetailsDataModel?
  
  init(modelContext: ModelContext, location: WeatherResultType) {
    self.modelContext = modelContext
    self.location = location
  }
  
  
  
  func getWeatherDetails() {
    switch location {
    case let .local(weatherLocationLocal):
      addRemoveButtonState = .remove
      publishLocalData(local: weatherLocationLocal)
      localData = weatherLocationLocal
    case let .search(weatherLocation):
      fetchLocationDetail(location: weatherLocation)
      addRemoveButtonState = .add
    }
  }
  
  func publishLocalData(local: WeatherDetailsDataModel) {
    viewState = .data(local.toWeatherDetailsModel)
  }
  
  func saveRemoveButtonClicked() {
    switch addRemoveButtonState {
    case .add:
      guard case let .data(details) = viewState else { return }
      localData = details.toWeatherDetailsDataModel
      saveWeatherDetails(details: localData!)
      addRemoveButtonState = .remove
    case .remove:
      guard case .data = viewState, let weatherlocalData = localData else { return }
      removeWeatherDetails(details: weatherlocalData)
      addRemoveButtonState = .add
      
      
    }
  }
  
  private func fetchLocationDetail(location: WeatherLocation) {
    viewState = .loading
    repository.getWeatherDetail(query: location.latAndLong, days: 5, hour: 10)
      .map { WeatherDetailsDataBuilder.build(response: $0) }
      .sink { error in
        self.handleCompition(error: error)
      } receiveValue: { [weak self] details in
        self?.updateViewState(details: details)
      }
      .store(in: &cancellables)
  }
  
  private func handleCompition(error: Subscribers.Completion<JaalError>) {
    switch error {
    case .finished:
      print("Compition")
    case let .failure(error):
      viewState = .error(error.localizedDescription)
    }
  }
  
  private func updateViewState(details: WeatherDetails) {
    viewState = .data(details)
  }
  
  private func saveWeatherDetails(details: WeatherDetailsDataModel) {
    modelContext.insert(details)
  }
  
  private func removeWeatherDetails(details: WeatherDetailsDataModel) {
    modelContext.delete(details)
  }
}


enum WeatherDetailsDataBuilder {
  static func build(response: WeatherDetailsResponse) -> WeatherDetails {
    return WeatherDetails(
      headerInfo: response.toWeatherHeaderInfoViewModel,
      forecastList: response.toForecastList, 
      precipitationInfo: response.precipInfo, 
      windInfo: response.windInfo, 
      uvIndexInfo: response.uvIndexInfo, 
      sunSetRiseInfo: response.sunSetRiseInfo, 
      alertsInfo: response.alertsInfo)
  }
}


extension WeatherDetailsResponse {
  var toWeatherHeaderInfoViewModel: WeatherHeaderInfoViewModel {
    WeatherHeaderInfoViewModel(
      locationName: location.name,
      locationAreaAndReagin: "\(location.region), \(location.country)",
      temperature: current.tempC,
      dayMaxTemp: forecast.forecastday.first?.day.maxtempC ?? 0.0,
      dayMinTemp: forecast.forecastday.first?.day.mintempC ?? 0.0,
      isDay: current.isDay == 1 ? true : false,
      imageCode: "\(WeatherConditionIcon.getImageIcon(code: current.condition.code))",
      feelsLikeTemp: current.feelslikeC
    )
  }
  
  var toForecastList: [FutureForecastInfoViewModel] {
    forecast.forecastday.map {
      FutureForecastInfoViewModel(
        id: $0.dateEpoch,
        date: $0.date.dayOfWeek() ?? $0.date,
        imageCode: "\(WeatherConditionIcon.getImageIcon(code: $0.day.condition.code))",
        minTemp: $0.day.mintempC,
        maxTemp: $0.day.maxtempC
      )
    }
  }
  
  var precipInfo: PrecipitationInfoViewModel {
    PrecipitationInfoViewModel(precipitationValue: "\(current.precipMm) mm")
  }
  
  var windInfo: WindInfoViewModel {
    WindInfoViewModel(windSpeed: String(format: "%.1f", current.windKph), windDirection: current.windDir)
  }
  
  var uvIndexInfo: UVIndexInfoViewModel {
    UVIndexInfoViewModel(indexValue: "\(current.uv)")
  }
  
  var sunSetRiseInfo: SunSetRiseInfoViewModel {
    guard let astro = forecast.forecastday.first?.astro else {
      return SunSetRiseInfoViewModel(sunriseTime: "--", sunsetTime: "--")
    }
    return SunSetRiseInfoViewModel(sunriseTime: astro.sunrise, sunsetTime: astro.sunset)
  }
  
  var alertsInfo: [AlertInfoViewModel] {
    alerts.alert.map { AlertInfoViewModel(
      headline: $0.headline,
      event: $0.event,
      effectiveToExpiresDate: "\($0.effective.formatDateInReadable()) - \($0.expires.formatDateInReadable())",
      alertDescription: $0.desc)
    }
  }
}



