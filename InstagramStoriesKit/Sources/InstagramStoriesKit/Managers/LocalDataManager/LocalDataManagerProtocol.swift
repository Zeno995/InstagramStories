//
//  LocalDataManagerProtocol.swift
//  InstagramStoriesKit
//
//  Created by Enzo on 22/06/25.
//

public protocol LocalDataManagerProtocol {
  func parseUserJson() -> Models.App.User.List
}
