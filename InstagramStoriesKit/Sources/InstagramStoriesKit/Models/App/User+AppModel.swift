//
//  User.swift
//  InstagramStoriesKit
//
//  Created by Enzo on 22/06/25.
//

import Foundation

public extension Models.App {
  struct User: Identifiable {
    public let id = UUID()
    let userId: Int
    let name: String
    let profilePictureUrl: URL?
  }
}

public extension Models.App.User {
  typealias List = [Self]
}
