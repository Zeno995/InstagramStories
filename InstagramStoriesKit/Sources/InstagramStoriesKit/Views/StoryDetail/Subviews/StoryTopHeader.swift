//
//  StoryTopHeader.swift
//  InstagramStoriesKit
//
//  Created by Enzo on 22/06/25.
//

import SwiftUI

public struct StoryTopHeader: View {
  let user: Models.App.User
  let timeAgo: String
  let onDismiss: () -> Void
  
  public init(
    user: Models.App.User,
    timeAgo: String,
    onDismiss: @escaping () -> Void
  ) {
    self.user = user
    self.timeAgo = timeAgo
    self.onDismiss = onDismiss
  }
  
  public var body: some View {
    HStack {
      HStack(spacing: 12) {
        AsyncImage(url: user.profilePictureUrl) { image in
          image
            .resizable()
            .aspectRatio(contentMode: .fill)
        } placeholder: {
          Circle()
            .fill(Color.gray.opacity(0.6))
            .overlay(
              Image(systemName: "person.fill")
                .foregroundColor(.white.opacity(0.8))
                .font(.system(size: 20))
            )
        }
        .frame(width: 44, height: 44)
        .clipShape(Circle())
        .overlay(
          Circle()
            .stroke(Color.white, lineWidth: 2)
        )
        
        HStack(alignment: .center, spacing: 4) {
          Text(user.name)
            .font(.system(size: 16, weight: .semibold))
            .foregroundColor(.white)
          
          Text(timeAgo)
            .font(.system(size: 14))
            .foregroundColor(.white.opacity(0.8))
        }
      }
      
      Spacer()
      
      Button(action: onDismiss) {
        Image(systemName: "xmark")
          .font(.system(size: 18, weight: .medium))
          .foregroundColor(.white)
          .frame(width: 44, height: 44)
      }
    }
    .padding(.horizontal, 16)
    .padding(.top, 16)
  }
} 
