//
//  StoriesListView.swift
//  InstagramStoriesKit
//
//  Created by Enzo on 22/06/25.
//

import SwiftUI

/// A `View` representing the users stories.
public struct StoriesListView: View {
  @StateObject private var viewModel: StoriesListViewModel
  
  public init(viewModel: StoriesListViewModel) {
    self._viewModel = StateObject(wrappedValue: viewModel)
  }
  
  public var body: some View {
    VStack(alignment: .leading, spacing: 0) {
      ScrollView(.horizontal, showsIndicators: false) {
        LazyHStack(spacing: 16) {
          UserStoryView()
          
          ForEach(viewModel.users) { user in
            StoryItemView(user: user) {
#warning("Tap user story")
            }
            .onAppear {
              if viewModel.shouldLoadMore(for: user) {
                viewModel.loadNextPage()
              }
            }
          }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
      }
    }
  }
}

// MARK: - SwiftUI Previews

struct StoriesListView_Previews: PreviewProvider {
  static var previews: some View {
    Group {
      StoriesListView(
        viewModel: StoriesListViewModel(
          localDataManager: MockedLocalDataManager()
        )
      )
      .previewDisplayName("Stories List")
      .preferredColorScheme(.light)
      
      StoriesListView(
        viewModel: StoriesListViewModel(
          localDataManager: MockedLocalDataManager()
        )
      )
      .previewDisplayName("Stories List - Dark Mode")
      .preferredColorScheme(.dark)
    }
  }
}
