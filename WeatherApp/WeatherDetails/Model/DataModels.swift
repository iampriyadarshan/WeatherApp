//
//  DataModels.swift
//  WeatherApp
//
//  Created by Priyadarshan Meshram on 30/03/24.
//

import Foundation
import SwiftData


struct WeatherDetails {
  let headerInfo: WeatherHeaderInfoViewModel
  let forecastList: [FutureForecastInfoViewModel]
  let precipitationInfo: PrecipitationInfoViewModel
  let windInfo: WindInfoViewModel
  let uvIndexInfo: UVIndexInfoViewModel
  let sunSetRiseInfo: SunSetRiseInfoViewModel
  let alertsInfo: [AlertInfoViewModel]
}

extension WeatherDetails {
  var toWeatherDetailsDataModel : WeatherDetailsDataModel {
    WeatherDetailsDataModel(
      headerInfo: headerInfo.toWeatherHeaderInfoDataModel,
      forecastList: forecastList.map { $0.toFutureForecastInfoDataModel},
      precipitationInfo: precipitationInfo.toPrecipitationInfoDataModel,
      windInfo: windInfo.toWindInfoDataModel,
      uvIndexInfo: uvIndexInfo.toUVIndexInfoDataModel,
      sunSetRiseInfo: sunSetRiseInfo.toSunSetRiseInfoDataModel,
      alertsInfo: alertsInfo.map { $0.toAlertInfoDataModel }
    )
  }
}

struct WeatherHeaderInfoViewModel {
  let locationName: String
  let locationAreaAndReagin: String
  let temperature: Double
  let dayMaxTemp: Double
  let dayMinTemp: Double
  let isDay: Bool
  let imageCode: String
  let feelsLikeTemp: Double
}

extension WeatherHeaderInfoViewModel {
  var toWeatherHeaderInfoDataModel : WeatherHeaderInfoDataModel {
    WeatherHeaderInfoDataModel(
      locationName: locationName,
      locationAreaAndReagin: locationAreaAndReagin,
      temperature: temperature,
      dayMaxTemp: dayMaxTemp,
      dayMinTemp: dayMinTemp,
      isDay: isDay,
      imageCode: imageCode,
      feelsLikeTemp: feelsLikeTemp
    )
  }
}


struct FutureForecastInfoViewModel: Identifiable {
  let id: Int
  let date: String
  let imageCode: String
  let minTemp: Double
  let maxTemp: Double
}

extension FutureForecastInfoViewModel {
  var toFutureForecastInfoDataModel: FutureForecastInfoDataModel {
    FutureForecastInfoDataModel(id: id, date: date, imageCode: imageCode, minTemp: minTemp, maxTemp: maxTemp)
  }
}

struct PrecipitationInfoViewModel {
  let precipitationValue: String
}

extension PrecipitationInfoViewModel {
  var toPrecipitationInfoDataModel: PrecipitationInfoDataModel {
    PrecipitationInfoDataModel(precipitationValue: precipitationValue)
  }
}


struct WindInfoViewModel {
  let windSpeed: String
  let windDirection: String
}

extension WindInfoViewModel {
  var toWindInfoDataModel: WindInfoDataModel {
    WindInfoDataModel(windSpeed: windSpeed, windDirection: windDirection)
  }
}

struct UVIndexInfoViewModel {
  let indexValue: String
}

extension UVIndexInfoViewModel {
  var toUVIndexInfoDataModel: UVIndexInfoDataModel {
    UVIndexInfoDataModel(indexValue: indexValue)
  }
}

struct SunSetRiseInfoViewModel {
  let sunriseTime: String
  let sunsetTime: String
}

extension SunSetRiseInfoViewModel {
  var toSunSetRiseInfoDataModel: SunSetRiseInfoDataModel {
    SunSetRiseInfoDataModel(sunriseTime: sunriseTime, sunsetTime: sunsetTime)
  }
}


struct AlertInfoViewModel: Identifiable {
  var id = UUID()
  let headline: String
  let event: String
  let effectiveToExpiresDate: String
  let alertDescription: String
}

extension AlertInfoViewModel {
  var toAlertInfoDataModel: AlertInfoDataModel {
    AlertInfoDataModel(id: id, headline: headline, event: event, effectiveToExpiresDate: effectiveToExpiresDate, alertDescription: alertDescription)
  }
}




@Model class WeatherDetailsDataModel {
  let headerInfo: WeatherHeaderInfoDataModel
  let forecastList: [FutureForecastInfoDataModel]
  let precipitationInfo: PrecipitationInfoDataModel
  let windInfo: WindInfoDataModel
  let uvIndexInfo: UVIndexInfoDataModel
  let sunSetRiseInfo: SunSetRiseInfoDataModel
  let alertsInfo: [AlertInfoDataModel]
  
  init(headerInfo: WeatherHeaderInfoDataModel, forecastList: [FutureForecastInfoDataModel], precipitationInfo: PrecipitationInfoDataModel, windInfo: WindInfoDataModel, uvIndexInfo: UVIndexInfoDataModel, sunSetRiseInfo: SunSetRiseInfoDataModel, alertsInfo: [AlertInfoDataModel]) {
    self.headerInfo = headerInfo
    self.forecastList = forecastList
    self.precipitationInfo = precipitationInfo
    self.windInfo = windInfo
    self.uvIndexInfo = uvIndexInfo
    self.sunSetRiseInfo = sunSetRiseInfo
    self.alertsInfo = alertsInfo
  }
}

extension WeatherDetailsDataModel {
  var toWeatherDetailsModel: WeatherDetails {
    WeatherDetails(
      headerInfo: headerInfo.toWeatherHeaderInfoViewModel,
      forecastList: forecastList.map { $0.toFutureForecastInfoViewModel },
      precipitationInfo: precipitationInfo.toPrecipitationInfoViewModel,
      windInfo: windInfo.toWindInfoViewModel,
      uvIndexInfo: uvIndexInfo.toUVIndexInfoViewModelModel,
      sunSetRiseInfo: sunSetRiseInfo.toSunSetRiseInfoViewModel,
      alertsInfo: alertsInfo.map { $0.toAlertInfoViewModel }
    )
  }
  
  var toWeatherCityInfoCardViewModel: WeatherCityInfoCardViewModel {
    WeatherCityInfoCardViewModel(name: headerInfo.locationName, areaRegion: headerInfo.locationAreaAndReagin, temp: headerInfo.temperature, imageCode: headerInfo.imageCode, time: forecastList.first?.date.dayOfWeek() ?? "")
  }
}

@Model class WeatherHeaderInfoDataModel {
  let locationName: String
  let locationAreaAndReagin: String
  let temperature: Double
  let dayMaxTemp: Double
  let dayMinTemp: Double
  let isDay: Bool
  let imageCode: String
  let feelsLikeTemp: Double
  
  init(locationName: String, locationAreaAndReagin: String, temperature: Double, dayMaxTemp: Double, dayMinTemp: Double, isDay: Bool, imageCode: String, feelsLikeTemp: Double) {
    self.locationName = locationName
    self.locationAreaAndReagin = locationAreaAndReagin
    self.temperature = temperature
    self.dayMaxTemp = dayMaxTemp
    self.dayMinTemp = dayMinTemp
    self.isDay = isDay
    self.imageCode = imageCode
    self.feelsLikeTemp = feelsLikeTemp
  }
}

extension WeatherHeaderInfoDataModel {
  var toWeatherHeaderInfoViewModel : WeatherHeaderInfoViewModel {
    WeatherHeaderInfoViewModel(
      locationName: locationName,
      locationAreaAndReagin: locationAreaAndReagin,
      temperature: temperature,
      dayMaxTemp: dayMaxTemp,
      dayMinTemp: dayMinTemp,
      isDay: isDay,
      imageCode: imageCode,
      feelsLikeTemp: feelsLikeTemp
    )
  }
}



@Model class FutureForecastInfoDataModel: Identifiable {
  let id: Int
  let date: String
  let imageCode: String
  let minTemp: Double
  let maxTemp: Double
  
  init(id: Int, date: String, imageCode: String, minTemp: Double, maxTemp: Double) {
    self.id = id
    self.date = date
    self.imageCode = imageCode
    self.minTemp = minTemp
    self.maxTemp = maxTemp
  }
}

extension FutureForecastInfoDataModel {
  var toFutureForecastInfoViewModel: FutureForecastInfoViewModel {
    FutureForecastInfoViewModel(id: id, date: date, imageCode: imageCode, minTemp: minTemp, maxTemp: maxTemp)
  }
}

@Model class PrecipitationInfoDataModel {
  let precipitationValue: String
  
  init(precipitationValue: String) {
    self.precipitationValue = precipitationValue
  }
}

extension PrecipitationInfoDataModel {
  var toPrecipitationInfoViewModel: PrecipitationInfoViewModel {
    PrecipitationInfoViewModel(precipitationValue: precipitationValue)
  }
}


@Model class WindInfoDataModel {
  let windSpeed: String
  let windDirection: String
  
  init(windSpeed: String, windDirection: String) {
    self.windSpeed = windSpeed
    self.windDirection = windDirection
  }
}

extension WindInfoDataModel {
  var toWindInfoViewModel: WindInfoViewModel {
    WindInfoViewModel(windSpeed: windSpeed, windDirection: windDirection)
  }
}

@Model class UVIndexInfoDataModel {
  let indexValue: String
  init(indexValue: String) {
    self.indexValue = indexValue
  }
}

extension UVIndexInfoDataModel {
  var toUVIndexInfoViewModelModel: UVIndexInfoViewModel {
    UVIndexInfoViewModel(indexValue: indexValue)
  }
}

@Model class SunSetRiseInfoDataModel {
  let sunriseTime: String
  let sunsetTime: String
  
  init(sunriseTime: String, sunsetTime: String) {
    self.sunriseTime = sunriseTime
    self.sunsetTime = sunsetTime
  }
}


extension SunSetRiseInfoDataModel {
  var toSunSetRiseInfoViewModel: SunSetRiseInfoViewModel {
    SunSetRiseInfoViewModel(sunriseTime: sunriseTime, sunsetTime: sunsetTime)
  }
}


@Model class AlertInfoDataModel: Identifiable {
  var id = UUID()
  let headline: String
  let event: String
  let effectiveToExpiresDate: String
  let alertDescription: String
  
  init(id: UUID = UUID(), headline: String, event: String, effectiveToExpiresDate: String, alertDescription: String) {
    self.id = id
    self.headline = headline
    self.event = event
    self.effectiveToExpiresDate = effectiveToExpiresDate
    self.alertDescription = alertDescription
  }
}

extension AlertInfoDataModel {
  var toAlertInfoViewModel: AlertInfoViewModel {
    AlertInfoViewModel(id: id, headline: headline, event: event, effectiveToExpiresDate: effectiveToExpiresDate, alertDescription: alertDescription)
  }
}
