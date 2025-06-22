//
//  Users.swift
//  InstagramStoriesKit
//
//  Created by Enzo on 22/06/25.
//

import Foundation

extension Models.Response {
  struct User: Decodable, Identifiable {
    let id: Int
    let name: String
    let profilePictureUrl: String
    
    private enum CodingKeys: String, CodingKey {
      case id, name
      case profilePictureUrl = "profile_picture_url"
    }
  }

  struct UsersCollection: Decodable {
    let pages: [UserPage]
  }

  struct UserPage: Decodable {
    let users: [User]
  }
}

extension Models.Response.User: Normalizable {
  func normalizedForApp() -> Models.App.User {
    Models.App.User(
      userId: id,
      name: name,
      profilePictureUrl: URL(string: profilePictureUrl)
    )
  }
}

extension Models.Response.UsersCollection: Normalizable {
  func normalizedForApp() -> Models.App.User.List {
    pages.flatMap(\.users).map({ $0.normalizedForApp() })
  }
}
