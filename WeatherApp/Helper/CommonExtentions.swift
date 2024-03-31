//
//  CommonExtentions.swift
//  WeatherApp
//
//  Created by Priyadarshan Meshram on 28/03/24.
//

import Foundation
import Jaal

extension TargetType {
  var baseURL: URL {
    AppNetworkConstantsProvider.shared.networkUrl
  }
}



//TODO: Move this to Utilities
extension String {
  func dayOfWeek() -> String? {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd" // Adjust the date format based on your input
    
    guard let date = dateFormatter.date(from: self) else {
      return nil // Return nil if the date string cannot be converted to a Date object
    }
    
    let calendar = Calendar.current
    
    if calendar.isDateInToday(date) {
      return "Today"
    } else {
      dateFormatter.dateFormat = "EEE"
      return dateFormatter.string(from: date)
    }
  }
  
  func formatDateInReadable() -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd'T'hh:mm:ssZ"
    if let date = dateFormatter.date(from: self) {
      let outputFormatter = DateFormatter()
      outputFormatter.dateFormat = "d MMM, yyyy h:mm a"
      outputFormatter.amSymbol = "am"
      outputFormatter.pmSymbol = "pm"
      return outputFormatter.string(from: date)
    }
    return ""
  }
}


