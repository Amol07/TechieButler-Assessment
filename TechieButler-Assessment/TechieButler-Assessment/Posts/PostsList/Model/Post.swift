//
//  Posts.swift
//  TechieButler-Assessment
//
//  Created by Amol Prakash on 29/05/24.
//

import Foundation

struct Post: Codable {
	let userId: Int
	let id: Int
	let title: String
	let body: String
}
