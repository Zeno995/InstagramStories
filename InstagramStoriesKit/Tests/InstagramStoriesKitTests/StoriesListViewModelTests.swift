//
//  StoriesListViewModelTests.swift
//  InstagramStoriesKit
//
//  Created by Enzo on 22/06/25.
//

import XCTest
@testable import InstagramStoriesKit

final class StoriesListViewModelTests: XCTestCase {
  
  // MARK: - Properties
  
  private var viewModel: StoriesListViewModel!
  private var mockDataManager: MockedLocalDataManager!
  
  // MARK: - Setup & Teardown
  
  override func setUp() {
    super.setUp()
    mockDataManager = MockedLocalDataManager()
    viewModel = StoriesListViewModel(localDataManager: mockDataManager)
  }
  
  override func tearDown() {
    viewModel = nil
    mockDataManager = nil
    super.tearDown()
  }
  
  // MARK: - Initialization Tests
  
  func testStoriesListViewModelInitialization() {
    // Given
    let mockManager = MockedLocalDataManager()
    
    // When
    let newViewModel = StoriesListViewModel(localDataManager: mockManager)
    
    // Then
    XCTAssertNotNil(newViewModel.localDataManager, "LocalDataManager should be initialized")
    XCTAssertEqual(newViewModel.users.count, 3, "Should load 3 users on initialization")
  }
  
  // MARK: - Data Loading Tests
  
  func testInitialDataLoading() {
    // Then
    XCTAssertEqual(viewModel.users.count, 3, "Should load 3 users initially")
    
    let expectedNames = ["pippo", "pluto", "paperino"]
    let actualNames = viewModel.users.map { $0.name }
    
    XCTAssertEqual(actualNames, expectedNames, "User names should match mock data")
  }
  
  func testLoadNextPage() {
    // Given
    let initialCount = viewModel.users.count
    
    // When
    viewModel.loadNextPage()
    
    // Then
    XCTAssertEqual(viewModel.users.count, initialCount + 3, "Should add 3 more users")
    
    // Verify the first 3 users remain unchanged
    let firstThreeNames = Array(viewModel.users.prefix(3)).map { $0.name }
    let expectedFirstThree = ["pippo", "pluto", "paperino"]
    XCTAssertEqual(firstThreeNames, expectedFirstThree, "First 3 users should remain unchanged")
    
    // Verify new users were added
    let nextThreeNames = Array(viewModel.users.dropFirst(3).prefix(3)).map { $0.name }
    let expectedNextThree = ["pippo", "pluto", "paperino"]
    XCTAssertEqual(nextThreeNames, expectedNextThree, "Next 3 users should be the same as the first ones")
  }
  
  // MARK: - Load More Logic Tests
  
  func testShouldLoadMoreForLastUser() {
    // Given
    let lastUser = viewModel.users.last!
    
    // When
    let shouldLoadMore = viewModel.shouldLoadMore(for: lastUser)
    
    // Then
    XCTAssertTrue(shouldLoadMore, "Should return true for the last user in the list")
  }
  
  func testShouldLoadMoreForFirstUser() {
    // Given
    let firstUser = viewModel.users.first!
    
    // When
    let shouldLoadMore = viewModel.shouldLoadMore(for: firstUser)
    
    // Then
    XCTAssertFalse(shouldLoadMore, "Should return false for the first user in the list")
  }
  
  func testShouldLoadMoreForMiddleUser() {
    // Given
    let middleUser = viewModel.users[1] // Second user (index 1)
    
    // When
    let shouldLoadMore = viewModel.shouldLoadMore(for: middleUser)
    
    // Then
    XCTAssertFalse(shouldLoadMore, "Should return false for a user in the middle of the list")
  }
  
  func testShouldLoadMoreForNonExistentUser() {
    // Given
    let nonExistentUser = Models.App.User(userId: 999, name: "Non Existent", profilePictureUrl: nil)
    
    // When
    let shouldLoadMore = viewModel.shouldLoadMore(for: nonExistentUser)
    
    // Then
    XCTAssertFalse(shouldLoadMore, "Should return false for a user not present in the list")
  }
  
  // MARK: - User Data Validation Tests
  
  func testUserDataStructure() {
    // Given
    let user = viewModel.users.first!
    
    // Then
    XCTAssertEqual(user.userId, 0, "First user should have userId = 0")
    XCTAssertEqual(user.name, "pippo", "First user should be named 'pippo'")
    XCTAssertNil(user.profilePictureUrl, "Profile picture URL should be nil")
    XCTAssertNotNil(user.id, "UUID id should be present")
  }
  
  func testAllUsersHaveUniqueIds() {
    // Given
    let userIds = viewModel.users.map { $0.id }
    let uniqueIds = Set(userIds)
    
    // Then
    XCTAssertEqual(userIds.count, uniqueIds.count, "All users should have unique UUID ids")
  }
  
  func testUsersSequentialUserIds() {
    // Given
    let userIds = viewModel.users.map { $0.userId }
    let expectedIds = [0, 1, 2]
    
    // Then
    XCTAssertEqual(userIds, expectedIds, "User IDs should be sequential: 0, 1, 2")
  }
} 
