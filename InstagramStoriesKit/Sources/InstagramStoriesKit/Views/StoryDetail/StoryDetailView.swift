//
//  StoryDetailView.swift
//  InstagramStoriesKit
//
//  Created by Enzo on 22/06/25.
//

import SwiftUI
import SwiftData

public struct StoryDetailView: View {
  @StateObject private var viewModel: StoryDetailViewModel
  @Environment(\.modelContext) private var modelContext
  
  @Query private var viewedStories: [ViewedStory]
  @Query private var likedStories: [LikedStory]
  
  @State private var currentStoryIsLiked: Bool = false
  
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
            onLike: {
              handleLikeStory()
            },
            isLiked: currentStoryIsLiked
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
    .onAppear {
      markStoryAsViewed()
      updateLikeStatus()
    }
    .onChange(of: viewModel.currentStoryIndex) { _, _ in
      markStoryAsViewed()
      updateLikeStatus()
    }
    .onChange(of: viewModel.currentUserIndex) { _, _ in
      markStoryAsViewed()
      updateLikeStatus()
    }
    .onChange(of: likedStories) { _, _ in
      updateLikeStatus()
    }
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
  
  private func markStoryAsViewed() {
    let currentStory = viewModel.currentStory
    let userId = viewModel.user.userId
    
    let alreadyViewed = viewedStories.contains { story in
      story.userId == userId && story.storyId == currentStory.id
    }
    
    if !alreadyViewed {
      let viewedStory = ViewedStory(userId: userId, storyId: currentStory.id)
      modelContext.insert(viewedStory)
      
      do {
        try modelContext.save()
      } catch {
        print("Error during data saving: \(error)")
      }
    }
  }
  
  private func isStoryLiked() -> Bool {
    let currentStory = viewModel.currentStory
    let userId = viewModel.user.userId
    
    let isLiked = likedStories.contains { story in
      story.userId == userId && story.storyId == currentStory.id
    }
    
    return isLiked
  }
  
  private func updateLikeStatus() {
    currentStoryIsLiked = isStoryLiked()
  }
  
  private func handleLikeStory() {
    let currentStory = viewModel.currentStory
    let userId = viewModel.user.userId
    
    if let existingLike = likedStories.first(where: { story in
      story.userId == userId && story.storyId == currentStory.id
    }) {
      modelContext.delete(existingLike)
      currentStoryIsLiked = false
    } else {
      let likedStory = LikedStory(userId: userId, storyId: currentStory.id)
      modelContext.insert(likedStory)
      currentStoryIsLiked = true
    }
    
    do {
      try modelContext.save()
    } catch {
      print("❌ Error during saving the liked story: \(error)")
      currentStoryIsLiked = !currentStoryIsLiked
    }
  }
}

// MARK: - SwiftUI Previews
struct StoryDetailView_Previews: PreviewProvider {
  static var previews: some View {
    Group {
      StoryDetailView(
        users: [
          Models.App.User(
            userId: 1,
            name: "Pippo",
            profilePictureUrl: URL(string: "https://picsum.photos/200/200?random=1")
          ),
          Models.App.User(
            userId: 2,
            name: "Pluto",
            profilePictureUrl: URL(string: "https://picsum.photos/200/200?random=2")
          ),
          Models.App.User(
            userId: 3,
            name: "Paperino",
            profilePictureUrl: URL(string: "https://picsum.photos/200/200?random=3")
          )
        ],
        initialUserIndex: 0,
        onDismiss: {}
      )
      .previewDisplayName("Story Detail")
    }
  }
}
