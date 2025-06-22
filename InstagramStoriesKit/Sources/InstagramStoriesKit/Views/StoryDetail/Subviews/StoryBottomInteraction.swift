//
//  StoryBottomInteraction.swift
//  InstagramStoriesKit
//
//  Created by Enzo on 22/06/25.
//

import SwiftUI

public struct StoryBottomInteraction: View {
  let onLike: () -> Void
  let isLiked: Bool
  @State private var messageText: String = ""
  @FocusState private var isTextFieldFocused: Bool
  
  public init(
    onLike: @escaping () -> Void,
    isLiked: Bool = false
  ) {
    self.onLike = onLike
    self.isLiked = isLiked
  }
  
  public var body: some View {
    HStack(spacing: 16) {
      TextField("Send message...", text: $messageText)
        .font(.system(size: 16))
        .foregroundColor(.white)
        .focused($isTextFieldFocused)
        .padding(.horizontal, 20)
        .padding(.vertical, 12)
        .background(
          RoundedRectangle(cornerRadius: 25)
            .stroke(Color.white.opacity(0.5), lineWidth: 1)
            .background(
              RoundedRectangle(cornerRadius: 25)
                .fill(Color.black.opacity(0.3))
            )
        )
      
      Button(action: onLike) {
        Image(systemName: isLiked ? "heart.fill" : "heart")
          .font(.system(size: 24, weight: .medium))
          .foregroundColor(isLiked ? .red : .white)
          .frame(width: 44, height: 44)
      }
      
      Button(action: {}) {
        Image(systemName: "paperplane")
          .font(.system(size: 24, weight: .medium))
          .foregroundColor(.white)
          .frame(width: 44, height: 44)
      }
    }
    .padding([.horizontal, .top], 16)
    .background(Color.black)
  }
} 
