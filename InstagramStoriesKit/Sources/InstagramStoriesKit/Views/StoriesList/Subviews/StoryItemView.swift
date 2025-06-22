//
//  StoryItemView.swift
//  InstagramStoriesKit
//
//  Created by Enzo on 22/06/25.
//

import SwiftUI

/// The `View` representing an user story.
struct StoryItemView: View {
  let user: Models.App.User
  let onTap: () -> Void
  
  var body: some View {
    Button(action: onTap) {
      VStack(spacing: 8) {
        ZStack {
          Circle()
            .stroke(
              LinearGradient(
                colors: [.purple, .pink, .orange, .yellow],
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
