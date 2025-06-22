//
//  StoryDetailViewModel.swift
//  InstagramStoriesKit
//
//  Created by Enzo on 22/06/25.
//

import SwiftUI
import Combine


public final class StoryDetailViewModel: ObservableObject {
  
  // MARK: - Stored Properties
  
  @Published var currentStoryIndex: Int = 0
  @Published var progress: Double = 0.0
  @Published var isPaused: Bool = false
  @Published var isDragging: Bool = false
  @Published var currentUserIndex: Int = 0
  
  let users: [Models.App.User]
  let onDismiss: () -> Void
  
  private var timer: Timer?
  private let storyDuration: TimeInterval = 5.0
  private let progressUpdateInterval: TimeInterval = 0.01
  private var storiesCache: [String: [StoryModel]] = [:]
  
  // MARK: - Computed Properties
  
  var user: Models.App.User {
    guard currentUserIndex < users.count else {
      return users.first ?? Models.App.User(userId: 0, name: "", profilePictureUrl: nil)
    }
    
    return users[currentUserIndex]
  }
  
  var stories: [StoryModel] {
    let userId = user.userId
    if let cachedStories = storiesCache[String(userId)] {
      return cachedStories
    } else {
      let newStories = StoryDetailViewModel.generateMockStories(for: userId)
      storiesCache[String(userId)] = newStories
      return newStories
    }
  }
  
  // MARK: - Initialization
  
  public init(
    users: [Models.App.User],
    initialUserIndex: Int = 0,
    onDismiss: @escaping () -> Void
  ) {
    self.users = users
    self.currentUserIndex = max(0, min(initialUserIndex, users.count - 1))
    self.onDismiss = onDismiss
    startTimer()
  }
  
  deinit {
    timer?.invalidate()
    timer = nil
  }
  
  // MARK: - Current Story
  
  var currentStory: StoryModel {
    guard currentStoryIndex < stories.count else {
      return stories.first ?? StoryModel(imageUrl: "", timeAgo: "1h")
    }
    return stories[currentStoryIndex]
  }
  
  // MARK: - Timer Management
  
  private func startTimer() {
    guard !isPaused else { return }
    
    timer = Timer.scheduledTimer(withTimeInterval: progressUpdateInterval, repeats: true) { [weak self] _ in
      Task { @MainActor in
        self?.updateProgress()
      }
    }
  }
  
  private func stopTimer() {
    timer?.invalidate()
    timer = nil
  }
  
  private func updateProgress() {
    guard !isPaused && !isDragging else { return }
    
    let increment = progressUpdateInterval / storyDuration
    progress += increment
    
    if progress >= 1.0 {
      nextStory()
    }
  }
  
  // MARK: - Navigation
  
  func nextStory() {
    if currentStoryIndex < stories.count - 1 {
      currentStoryIndex += 1
      progress = 0.0
    } else {
      nextUser()
    }
  }
  
  func previousStory() {
    if currentStoryIndex > 0 {
      currentStoryIndex -= 1
      progress = 0.0
    } else {
      previousUser()
    }
  }
  
  func nextUser() {
    if currentUserIndex < users.count - 1 {
      currentUserIndex += 1
      currentStoryIndex = 0
      progress = 0.0
    } else {
      onDismiss()
    }
  }
  
  func previousUser() {
    if currentUserIndex > 0 {
      currentUserIndex -= 1
      currentStoryIndex = max(0, stories.count - 1)
      progress = 0.0
    }
  }
  
  // MARK: - User Interactions
  
  func pauseStory() {
    isPaused = true
    stopTimer()
  }
  
  func resumeStory() {
    isPaused = false
    stopTimer()
    startTimer()
  }
  
  func handleTapGesture(at location: CGPoint, in geometry: CGSize) {
    let tapThreshold = geometry.width / 2
    
    if location.x < tapThreshold {
      previousStory()
    } else {
      nextStory()
    }
  }
  
  func handleLongPressStart() {
    pauseStory()
  }
  
  func handleLongPressEnd() {
    resumeStory()
  }
}

// MARK: - Mock Data

private extension StoryDetailViewModel {
  static func generateMockStories(for userId: Int) -> [StoryModel] {
    let numberOfStories = (userId % 4) + 2
    
    let timeAgoOptions = ["1 min", "5 min", "15 min", "1 h", "2 h", "3 h", "4 h", "5 h", "12 h", "22 h"]
    
    return (0..<numberOfStories).map { index in
      let storyId = "story_\(userId)_\(index)"
      let imageId = (userId * 100) + index + 1
      
      return StoryModel(
        imageUrl: "https://picsum.photos/390/844?random=\(imageId)",
        timeAgo: timeAgoOptions[index % timeAgoOptions.count],
        id: storyId
      )
    }
  }
}

