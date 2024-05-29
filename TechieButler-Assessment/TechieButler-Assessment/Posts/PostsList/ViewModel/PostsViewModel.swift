//
//  File.swift
//  TechieButler-Assessment
//
//  Created by Amol Prakash on 29/05/24.
//

import Foundation

/// A protocol that defines the behavior of a view model for a list of posts.
protocol PostsViewModelProtocol {
	/// A closure that is called when the posts are updated.
	var onPostsUpdated: (() -> Void)? { get set }

	/// A closure that is called when an error occurs.
	var onError: ((Error) -> Void)? { get set }

	/// A boolean value indicating whether there is another batch of posts available.
	var isNextBatchAvailable: Bool { get }

	/// Fetches the posts.
	func fetchPosts()

	/// Returns the number of posts.
	///
	/// - Returns: The number of posts.
	func numberOfPosts() -> Int

	/// Returns the post at the given index.
	///
	/// - Parameter index: The index of the post to return.
	/// - Returns: The post at the given index.
	func post(at index: Int) -> Post
}

class PostsViewModel: PostsViewModelProtocol {
	private var posts: [Post] = []
	private var currentPage = 1
	private var limit = 10
	private var isLoading = false
	private let postFetchService: PostFetchServiceProtocol

	var onPostsUpdated: (() -> Void)?
	var onError: ((Error) -> Void)?

	private(set) var isNextBatchAvailable: Bool = false

	/// Initializes the view model with a post fetch service.
	///
	/// - Parameter postFetchService: The service to use for fetching posts. Defaults to `PostFetchService()`.
	init(postFetchService: PostFetchServiceProtocol = PostFetchService()) {
		self.postFetchService = postFetchService
	}

	func fetchPosts() {
		guard !isLoading else { return }
		isLoading = true

		postFetchService.fetchPosts(page: currentPage, limit: limit) { [weak self] result in
			guard let self = self else { return }
			self.isLoading = false

			switch result {
				case .success(let newPosts):
					self.isNextBatchAvailable = newPosts.count == limit
					self.posts.append(contentsOf: newPosts)
					self.currentPage += 1
					self.onPostsUpdated?()
				case .failure(let error):
					self.onError?(error)
			}
		}
	}

	func numberOfPosts() -> Int {
		return posts.count
	}

	func post(at index: Int) -> Post {
		return posts[index]
	}
}

