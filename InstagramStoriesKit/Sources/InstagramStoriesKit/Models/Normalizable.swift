//
//  Normalizable.swift
//  InstagramStoriesKit
//
//  Created by Enzo on 22/06/25.
//

/// A protocol all API response models should adhere to.
/// `func normalizedForApp() -> model` serves as a bridge between models arriving from the API services
/// and models created for the app with the UI and app architecture in mind.
public protocol Normalizable {
  associatedtype NormalizedModel

  func normalizedForApp() -> NormalizedModel
}
