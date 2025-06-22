// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "InstagramStoriesKit",
  platforms: [
    .iOS(.v16),
    .macOS(.v13)
  ],
  products: [
    .library(
      name: "InstagramStoriesKit",
      targets: ["InstagramStoriesKit"]
    ),
  ],
  dependencies: [],
  targets: [
    .target(
      name: "InstagramStoriesKit",
      dependencies: [],
      resources: [
        .process("users.json")
      ]
    ),
    .testTarget(
      name: "InstagramStoriesKitTests",
      dependencies: ["InstagramStoriesKit"]
    ),
  ]
) 
