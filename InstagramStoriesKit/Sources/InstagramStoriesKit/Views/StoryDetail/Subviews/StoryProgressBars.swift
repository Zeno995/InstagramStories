//
//  StoryProgressBars.swift
//  InstagramStoriesKit
//
//  Created by Enzo on 22/06/25.
//

import SwiftUI

public struct StoryProgressBars: View {
  let storiesCount: Int
  let currentStoryIndex: Int
  let progress: Double
  let screenWidth: CGFloat
  
  public init(
    storiesCount: Int,
    currentStoryIndex: Int,
    progress: Double,
    screenWidth: CGFloat
  ) {
    self.storiesCount = storiesCount
    self.currentStoryIndex = currentStoryIndex
    self.progress = progress
    self.screenWidth = screenWidth
  }
  
  public var body: some View {
    HStack(spacing: 4) {
      ForEach(.zero ..< storiesCount, id: \.self) { index in
        Rectangle()
          .fill(Color.white.opacity(0.3))
          .frame(height: 2)
          .overlay(
            Rectangle()
              .fill(Color.white)
              .frame(width: progressWidth(for: index))
              .animation(.linear(duration: 0.1), value: progress)
              .animation(.easeInOut(duration: 0.3), value: currentStoryIndex),
            alignment: .leading
          )
      }
    }
    .padding(.horizontal, 16)
    .padding(.top, 12)
  }
  
  private func progressWidth(for index: Int) -> CGFloat {
    let totalWidth = screenWidth - 32 - CGFloat(storiesCount - 1) * 4
    let segmentWidth = totalWidth / CGFloat(storiesCount)
    
    if index < currentStoryIndex {
      return segmentWidth
    } else if index == currentStoryIndex {
      return segmentWidth * CGFloat(progress)
    } else {
      return .zero
    }
  }
} 
