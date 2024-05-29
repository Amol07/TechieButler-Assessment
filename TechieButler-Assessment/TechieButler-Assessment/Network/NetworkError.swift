//
//  NetworkError.swift
//  TechieButler-Assessment
//
//  Created by Amol Prakash on 29/05/24.
//

import Foundation

/// Enum representing the possible network errors.
enum NetworkError: Error {
	/// Indicates an invalid URL error.
	case invalidURL
	/// Indicates a request failure with an associated error.
	case requestFailed(Error)
	/// Indicates a decoding failure with an associated error.
	case decodingFailed(Error)
	/// Indicates a server error with an associated status code.
	case serverError(Int)
	/// Indicates an unknown error.
	case unknown
	/// Indicates no data in the response.
	case noData
}
