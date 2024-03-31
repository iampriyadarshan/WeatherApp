//
//  WeatherAppApp.swift
//  WeatherApp
//
//  Created by Priyadarshan Meshram on 28/03/24.
//

import SwiftUI
import SwiftData


@main
struct WeatherAppApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
          WeatherDetailsDataModel.self
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
          WeatherSearchView(viewModel: WeatherSearchViewModel(modelContext: sharedModelContainer.mainContext))
        }
        .modelContainer(sharedModelContainer)
    }
}
