//
//  StoryModel.swift
//  InstagramStoriesKit
//
//  Created by Enzo on 22/06/25.
//

import Foundation

struct StoryModel: Identifiable {
  let id = UUID()
  let imageUrl: String
  let timeAgo: String
  
  init(imageUrl: String, timeAgo: String) {
    self.imageUrl = imageUrl
    self.timeAgo = timeAgo
  }
}
