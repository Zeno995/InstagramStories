//
//  SwiftDataModels.swift
//  InstagramStoriesKit
//
//  Created by Enzo on 22/06/25.
//

import Foundation
import SwiftData

@Model
public class ViewedStory {
  public var userId: Int
  public var storyId: String
  public var viewedAt: Date
  
  public init(userId: Int, storyId: String, viewedAt: Date = Date()) {
    self.userId = userId
    self.storyId = storyId
    self.viewedAt = viewedAt
  }
}

@Model
public class LikedStory {
  public var userId: Int
  public var storyId: String
  public var likedAt: Date
  
  public init(userId: Int, storyId: String, likedAt: Date = Date()) {
    self.userId = userId
    self.storyId = storyId
    self.likedAt = likedAt
  }
} 
