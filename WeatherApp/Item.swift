//
//  Item.swift
//  WeatherApp
//
//  Created by Priyadarshan Meshram on 27/03/24.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
