//
//  LocalDataParser.swift
//  InstagramStoriesKit
//
//  Created by Enzo on 22/06/25.
//

import Foundation

public struct LocalDataManager: LocalDataManagerProtocol {
  public init() {}
  
  public func parseUserJson() -> Models.App.User.List {
    guard
      let url = Bundle.module.url(forResource: "users", withExtension: "json"),
      let data = try? Data(contentsOf: url),
      let response = try? JSONDecoder().decode(Models.Response.UsersCollection.self, from: data)
    else {
      return []
    }
    
    return response.normalizedForApp()
  }
}
