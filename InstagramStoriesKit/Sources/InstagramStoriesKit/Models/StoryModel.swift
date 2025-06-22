//
//  StoryModel.swift
//  InstagramStoriesKit
//
//  Created by Enzo on 22/06/25.
//

import Foundation

struct StoryModel: Identifiable {
  let id: String
  let imageUrl: String
  let timeAgo: String
  
  init(imageUrl: String, timeAgo: String, id: String? = nil) {
    self.imageUrl = imageUrl
    self.timeAgo = timeAgo
    self.id = id ?? UUID().uuidString
  }
}
