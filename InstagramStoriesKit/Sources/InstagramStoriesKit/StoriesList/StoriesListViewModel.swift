//
//  StoriesListViewModel.swift
//  InstagramStoriesKit
//
//  Created by Enzo on 22/06/25.
//

import SwiftUI
import Foundation

// MARK: - ViewModel

public class StoriesListViewModel: ObservableObject {
  @Published var users: Models.App.User.List = []
  let localDataManager: LocalDataManagerProtocol
  
  public init(localDataManager: LocalDataManagerProtocol) {
    self.localDataManager = localDataManager
    loadNextPage()
  }

  func loadNextPage() {
    let newUsers = localDataManager.parseUserJson()
    users.append(contentsOf: newUsers)
  }
  
  func shouldLoadMore(for user: Models.App.User) -> Bool {
    users.lastIndex(where: { $0.id == user.id }) == users.count - 1
  }
}
