//
//  StoryDetailView.swift
//  InstagramStoriesKit
//
//  Created by Enzo on 22/06/25.
//

import SwiftUI

public struct StoryDetailView: View {
  @StateObject private var viewModel: StoryDetailViewModel
  @Environment(\.dismiss) private var dismiss
  
  public init(
    users: [Models.App.User],
    initialUserIndex: Int = 0,
    onDismiss: @escaping () -> Void = {}
  ) {
    self._viewModel = StateObject(wrappedValue: StoryDetailViewModel(
      users: users,
      initialUserIndex: initialUserIndex,
      onDismiss: onDismiss
    ))
  }
  
  public var body: some View {
    GeometryReader { geometry in
      ZStack {
        storyBackgroundImage(geometry: geometry)
        
        VStack(spacing: 0) {
          StoryProgressBars(
            storiesCount: viewModel.stories.count,
            currentStoryIndex: viewModel.currentStoryIndex,
            progress: viewModel.progress,
            screenWidth: geometry.size.width
          )
          
          StoryTopHeader(
            user: viewModel.user,
            timeAgo: viewModel.currentStory.timeAgo,
            onDismiss: viewModel.onDismiss
          )
          
          Spacer()
          
          StoryBottomInteraction(
            onLike: viewModel.likeStory
          )
        }
        .padding(.top, geometry.safeAreaInsets.top)
        .padding(.bottom, geometry.safeAreaInsets.bottom)
        
        VStack {
          Rectangle()
            .fill(Color.black)
            .frame(height: geometry.safeAreaInsets.top + 10) 
          Spacer()
        }
        
        VStack {
          Spacer()
          Rectangle()
            .fill(Color.black)
            .frame(height: geometry.safeAreaInsets.bottom)
        }
      }
      .ignoresSafeArea()
    }
    .preferredColorScheme(.dark)
  }
  
  /// The story background image with gestures recognition for stories interaction.
  @ViewBuilder
  private func storyBackgroundImage(geometry: GeometryProxy) -> some View {
    AsyncImage(url: URL(string: viewModel.currentStory.imageUrl)) { image in
      image
        .resizable()
        .aspectRatio(contentMode: .fill)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .clipped()
    } placeholder: {
      Rectangle()
        .fill(
          LinearGradient(
            colors: [.gray.opacity(0.8), .gray.opacity(0.6)],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
          )
        )
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .overlay(
          ProgressView()
            .scaleEffect(1.5)
            .tint(.white)
        )
    }
    .contentShape(Rectangle())
    .onTapGesture { location in
      viewModel.handleTapGesture(at: location, in: geometry.size)
    }
    .onLongPressGesture(
      minimumDuration: 0.2,
      maximumDistance: 50,
      pressing: { pressing in
        if pressing {
          viewModel.handleLongPressStart()
        } else {
          viewModel.handleLongPressEnd()
        }
      },
      perform: {}
    )
  }
}

// MARK: - SwiftUI Previews
struct StoryDetailView_Previews: PreviewProvider {
  static var previews: some View {
    Group {
      // Preview con nuovo initializer
      StoryDetailView(
        users: [
          Models.App.User(
            userId: 1,
            name: "chiarasoracco",
            profilePictureUrl: URL(string: "https://picsum.photos/200/200?random=1")
          ),
          Models.App.User(
            userId: 2,
            name: "johnsmith",
            profilePictureUrl: URL(string: "https://picsum.photos/200/200?random=2")
          ),
          Models.App.User(
            userId: 3,
            name: "mariabrown",
            profilePictureUrl: URL(string: "https://picsum.photos/200/200?random=3")
          )
        ],
        initialUserIndex: 0,
        onDismiss: {}
      )
      .previewDisplayName("Story Detail - Multi Users")
    }
  }
}

