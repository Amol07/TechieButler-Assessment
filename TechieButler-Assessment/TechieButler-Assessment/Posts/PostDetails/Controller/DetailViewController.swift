//
//  DetailViewController.swift
//  TechieButler-Assessment
//
//  Created by Amol Prakash on 29/05/24.
//

import UIKit

class DetailViewController: UIViewController {
	var post: Post?
	private let detailLabel = UILabel()

	override func viewDidLoad() {
		super.viewDidLoad()
		setupDetailView()
	}

	private func setupDetailView() {
		self.title = post?.title
		self.view.backgroundColor = .white
		view.addSubview(detailLabel)
		detailLabel.pinToSuperview()
		detailLabel.numberOfLines = 0
		detailLabel.textAlignment = .center

		if let post = post {
			detailLabel.text = post.body
		}
	}
}

