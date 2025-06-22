//
//  InstagramStoriesKitTests.swift
//  InstagramStoriesKit
//
//  Created by Enzo on 22/06/25.
//

import XCTest
@testable import InstagramStoriesKit

final class InstagramStoriesKitTests: XCTestCase {
  func testVersion() {
    XCTAssertEqual(InstagramStoriesKit.version, "1.0.0")
  }
}
