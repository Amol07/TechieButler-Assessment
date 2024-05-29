//
//  PostTableViewCell.swift
//  TechieButler-Assessment
//
//  Created by Amol Prakash on 29/05/24.
//

import UIKit

class PostTableViewCell: UITableViewCell {
	static let reuseIdentifier = "PostTableViewCell"

	private let idLabel = UILabel()
	private let titleLabel = UILabel()

	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		setupViews()
	}

	override func prepareForReuse() {
		super.prepareForReuse()
		idLabel.text = ""
		titleLabel.text = ""
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	private func setupViews() {
		idLabel.translatesAutoresizingMaskIntoConstraints = false
		titleLabel.translatesAutoresizingMaskIntoConstraints = false
		idLabel.font = .boldSystemFont(ofSize: 16)

		contentView.addSubview(idLabel)
		contentView.addSubview(titleLabel)

		NSLayoutConstraint.activate([
			idLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
			idLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
			idLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),

			titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
			titleLabel.topAnchor.constraint(equalTo: idLabel.bottomAnchor, constant: 8),
			titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
			titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
		])
	}

	/// Configures the view with the given post and computed detail.
	///
	/// - Parameters:
	///   - post: The post to display.
	///   - computedDetail: The computed detail to display.
	func configure(with post: Post, computedDetail: String) {
		idLabel.text = "\(post.id)"
		titleLabel.text = computedDetail
	}
}

