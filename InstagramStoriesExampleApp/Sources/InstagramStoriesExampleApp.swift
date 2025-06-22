//
//  InstagramStoriesExampleApp.swift
//  InstagramStoriesExampleApp
//
//  Created by Enzo on 22/06/25.
//

import SwiftUI
import SwiftData
import InstagramStoriesKit

@main
struct InstagramStoriesExampleApp: App {
  var body: some Scene {
    WindowGroup {
      ContentView()
        .modelContainer(for: [ViewedStory.self, LikedStory.self])
    }
  }
}
