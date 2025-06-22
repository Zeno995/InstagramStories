//
//  StoryItemView.swift
//  InstagramStoriesKit
//
//  Created by Enzo on 22/06/25.
//

import SwiftUI
import SwiftData

/// The `View` representing an user story.
struct StoryItemView: View {
  let user: Models.App.User
  let onTap: () -> Void
  
  @Environment(\.modelContext) private var modelContext
  @Query private var allViewedStories: [ViewedStory]
  
  private var hasUnviewedStories: Bool {
    let userViewedStories = allViewedStories.filter { $0.userId == user.userId }
    return userViewedStories.isEmpty
  }
  
  var body: some View {
    Button(action: onTap) {
      VStack(spacing: 8) {
        ZStack {
          Circle()
            .stroke(
              hasUnviewedStories ? 
                LinearGradient(
                  colors: [.purple, .pink, .orange, .yellow],
                  startPoint: .topLeading,
                  endPoint: .bottomTrailing
                ) :
                LinearGradient(
                  colors: [.gray, .gray],
                  startPoint: .topLeading,
                  endPoint: .bottomTrailing
                ),
              lineWidth: 3
            )
            .frame(width: 80, height: 80)
          
          AsyncImage(url: user.profilePictureUrl) { image in
            image
              .resizable()
              .aspectRatio(contentMode: .fill)
          } placeholder: {
            Circle()
              .fill(Color.gray.opacity(0.3))
              .overlay(
                ProgressView()
                  .scaleEffect(0.8)
              )
          }
          .frame(width: 72, height: 72)
          .clipShape(Circle())
        }
        
        Text(user.name)
          .font(.caption)
          .foregroundColor(.primary)
          .lineLimit(1)
          .frame(width: 80)
      }
    }
    .buttonStyle(PlainButtonStyle())
  }
}
