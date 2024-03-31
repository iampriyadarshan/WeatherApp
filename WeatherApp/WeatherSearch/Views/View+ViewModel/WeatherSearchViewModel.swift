//
//  WeatherSearchViewModel.swift
//  WeatherApp
//
//  Created by Priyadarshan Meshram on 28/03/24.
//

import Foundation
import Combine
import Jaal
import SwiftData


enum WeatherSearchViewState {
  case empty
  case data
}

enum WeatherResultType: Hashable, Identifiable {
  var id: Self  {
    self
  }
  case local(WeatherDetailsDataModel)
  case search(WeatherLocation)
  
  var isLocalData: Bool {
    guard case .local = self else { return false }
    return true
  }
}


class WeatherSearchViewModel: ObservableObject {
  
  @Injected(\.weatherSearchRepository) private var repository: WeatherSearchRepositoryType
  
  @Published var searchQuery: String = ""
  @Published var list: [WeatherResultType] = [WeatherResultType]()
  @Published var viewState: WeatherSearchViewState = .empty
  @Published var canDelete: Bool = false
  
  private var cancellables = Set<AnyCancellable>()

  private let modelContext: ModelContext
  
  init(modelContext: ModelContext) {
    self.modelContext = modelContext
  }
  

  
  func bindSearchQuery() {
    $searchQuery
      .debounce(for: 0.3, scheduler: DispatchQueue.main)
      .map { [self] searchQuery in
        repository.getWeatherList(for: searchQuery)
          .replaceError(with: [])
        }
      .switchToLatest()
      .receive(on: DispatchQueue.main)
      .sink(receiveValue: { [weak self] result in
        self?.publishData(result: result)
      })
      .store(in: &cancellables)
  }
  
  func deleteItem(offsets: IndexSet) {
    for index in offsets {
      if case let .local(detail) = list[index] {
        modelContext.delete(detail)
        list.remove(at: index)
      }
    }
    publishData(result: [])
  }
  
  private func getStoredLocationList() -> [WeatherDetailsDataModel] {
    do {
      let localList = try modelContext.fetch(FetchDescriptor<WeatherDetailsDataModel>())
      return localList
    } catch {
      return []
    }
  }
  
  private func publishData(result: [WeatherLocation]) {
    if result.isEmpty  {
      list = getStoredLocationList().map { .local($0) }
    } else {
      list = result.map { .search($0) }
    }  
    canDelete = list.allSatisfy { $0.isLocalData }
    viewState = list.isEmpty ? .empty : .data
  }
  
  
}
