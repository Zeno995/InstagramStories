//
//  ContentView.swift
//  InstagramStoriesExampleApp
//
//  Created by Enzo on 22/06/25.
//

import SwiftUI
import InstagramStoriesKit

struct ContentView: View {
  var body: some View {
    NavigationView {
      VStack {
        StoriesListView(
          viewModel: StoriesListViewModel(
            localDataManager: LocalDataManager()
          )
        )
        .padding(.top, 32)
        
        Spacer()
      }
      .navigationTitle("InstagramStoriesKit Example")
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
