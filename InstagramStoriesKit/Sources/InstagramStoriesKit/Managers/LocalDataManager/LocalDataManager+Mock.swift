//
//  LocalDataManager+Mock.swift
//  InstagramStoriesKit
//
//  Created by Enzo on 22/06/25.
//

struct MockedLocalDataManager: LocalDataManagerProtocol {

  public func parseUserJson() -> Models.App.User.List {
    return [
      Models.App.User(userId: 0, name: "pippo", profilePictureUrl: nil),
      Models.App.User(userId: 1, name: "pluto", profilePictureUrl: nil),
      Models.App.User(userId: 2, name: "paperino", profilePictureUrl: nil)
    ]
  }
}
