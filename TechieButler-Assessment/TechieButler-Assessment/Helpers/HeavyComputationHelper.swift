//
//  HeavyComputationHelper.swift
//  TechieButler-Assessment
//
//  Created by Amol Prakash on 29/05/24.
//


import Foundation

/// Protocol for helper classes that can perform heavy computations.
protocol HeavyComputationHelperProtocol {
	/// Performs a heavy computation for a given post and returns the result via a completion handler.
	///
	/// - Parameters:
	///   - post: The post for which the heavy computation should be performed.
	///   - completion: A closure that takes a string as a parameter and is called when the computation is complete.
	func heavyComputation(for post: Post, completion: @escaping (String) -> Void)
}

/// A concrete implementation of the `HeavyComputationHelperProtocol` that caches the results of heavy computations.
class HeavyComputationHelper: HeavyComputationHelperProtocol {
	/// A dictionary that stores the results of heavy computations based on the post ID.
	private var computationCache: [Int: String] = [:]

	/// Performs a heavy computation for a given post and returns the result via a completion handler.
	///
	/// This implementation first checks if the result of the computation is already cached. If it is, the cached result is returned.
	/// Otherwise, the computation is performed in the background and the result is cached for future use.
	///
	/// - Parameters:
	///   - post: The post for which the heavy computation should be performed.
	///   - completion: A closure that takes a string as a parameter and is called when the computation is complete.
	func heavyComputation(for post: Post, completion: @escaping (String) -> Void) {
		if let cachedResult = computationCache[post.id] {
			// If the result is already cached, return it immediately.
			completion(cachedResult)
			return
		}

		// Perform the computation in the background.
		DispatchQueue.global(qos: .background).async {
			let start = Date()

			// The heavy computation is simulated by creating a string with a length proportional to the length of the post title.
			let _ = String(repeating: "x", count: post.title.count * 10000)

			let end = Date()
			let timeInterval: Double = end.timeIntervalSince(start)
			print("Heavy computation took \(timeInterval) seconds")

			// Cache the result for future use.
			self.computationCache[post.id] = post.title
			completion(post.title)
		}
	}
}


