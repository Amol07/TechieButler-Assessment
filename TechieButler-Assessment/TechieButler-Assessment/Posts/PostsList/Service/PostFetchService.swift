//
//  PostFetchService.swift
//  TechieButler-Assessment
//
//  Created by Amol Prakash on 29/05/24.
//

import Foundation

/// Protocol for services that can fetch posts.
protocol PostFetchServiceProtocol {
	/// Fetches posts with the given page and limit, and calls the completion handler with the result.
	///
	/// - Parameters:
	///   - page: The page number to fetch.
	///   - limit: The number of posts to fetch per page.
	///   - completion: A closure that takes a `Result` as a parameter and is called when the fetch is complete.
	func fetchPosts(page: Int, limit: Int, completion: @escaping (Result<[Post], NetworkError>) -> Void)
}

/// A concrete implementation of `PostFetchServiceProtocol` that uses a `NetworkServiceProtocol` to fetch posts.
class PostFetchService: PostFetchServiceProtocol {
	/// The network service used to send requests.
	private let networkService: NetworkServiceProtocol

	/// Initializes the post fetch service with a network service.
	///
	/// - Parameter networkService: The network service to use. Defaults to `NetworkService()`.
	init(networkService: NetworkServiceProtocol = NetworkService()) {
		self.networkService = networkService
	}

	func fetchPosts(page: Int, limit: Int, completion: @escaping (Result<[Post], NetworkError>) -> Void) {
		let request = PostRequest(limit: limit, page: page)

		networkService.sendRequest(request) { (result: Result<[Post], NetworkError>) in
			completion(result)
		}
	}
}
