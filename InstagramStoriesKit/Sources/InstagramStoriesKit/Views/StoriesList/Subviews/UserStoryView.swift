//
//  UserStoryView.swift
//  InstagramStoriesKit
//
//  Created by Enzo on 22/06/25.
//

import SwiftUI

/// The `View` representing the current user story, with the button to add a new story.
struct UserStoryView: View {
  var body: some View {
    VStack(spacing: 8) {
      ZStack {
        Circle()
          .fill(
            LinearGradient(
              colors: [.gray.opacity(0.1)],
              startPoint: .topLeading,
              endPoint: .bottomTrailing
            )
          )
          .frame(width: 80, height: 80)
        
        Circle()
          .fill(Color.gray.opacity(0.3))
          .frame(width: 72, height: 72)
        
        Circle()
          .fill(Color.blue)
          .frame(width: 24, height: 24)
          .overlay(
            Image(systemName: "plus")
              .foregroundColor(.white)
              .font(.system(size: 12, weight: .bold))
          )
          .offset(x: 28, y: 28)
      }
      
      Text("Your story")
        .font(.caption)
        .foregroundColor(.primary)
        .lineLimit(1)
        .frame(width: 80)
    }
  }
}
