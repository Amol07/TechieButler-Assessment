//
//  PostRequest.swift
//  TechieButler-Assessment
//
//  Created by Amol Prakash on 29/05/24.
//

import Foundation

struct PostRequest: URLRequestProtocol {

	var baseURL: String { return "https://jsonplaceholder.typicode.com" }
	var path: String? { return "/posts" }
	var method: HTTPMethod { return .get }
	var queryParams: [String: String]?
	var headers: [String : String]? { nil }
	var bodyParams: [String : Any]? { nil }

	/// Initializes a new instance of `PokemonListRequestBuilder` with the provided limit and page.
	/// - Parameters:
	///   - limit: The number of Pokémon to fetch.
	///   - page: The page number for pagination.
	init(limit: Int, page: Int) {
		self.queryParams = ["_limit": "\(limit)", "_page": "\(page)"]
	}
}
