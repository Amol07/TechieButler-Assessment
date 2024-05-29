//
//  PostsViewController.swift
//  TechieButler-Assessment
//
//  Created by Amol Prakash on 29/05/24.
//

import UIKit

class PostsViewController: UIViewController {
	/// The table view that displays the posts.
	private let tableView = UITableView()

	/// The view model that provides data for the view.
	private var viewModel: PostsViewModelProtocol

	/// The helper that performs heavy computations.
	private let heavyComputationHelper: HeavyComputationHelperProtocol

	/// Initializes the view with a view model and a heavy computation helper.
	///
	/// - Parameters:
	///   - viewModel: The view model to use. Defaults to `PostsViewModel()`.
	///   - heavyComputationHelper: The heavy computation helper to use. Defaults to `HeavyComputationHelper()`.
	init(viewModel: PostsViewModelProtocol = PostsViewModel(),
		 heavyComputationHelper: HeavyComputationHelperProtocol = HeavyComputationHelper()) {
		self.viewModel = viewModel
		self.heavyComputationHelper = heavyComputationHelper
		super.init(nibName: nil, bundle: nil)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		self.title = "Posts"
		setupTableView()
		setupBindings()
		viewModel.fetchPosts()
	}

	private func setupTableView() {
		tableView.translatesAutoresizingMaskIntoConstraints = false
		tableView.register(PostTableViewCell.self, forCellReuseIdentifier: PostTableViewCell.reuseIdentifier)
		tableView.dataSource = self
		tableView.delegate = self
		view.addSubview(tableView)
		tableView.pinToSuperview()
	}

	private func setupBindings() {
		viewModel.onPostsUpdated = { [weak self] in
			self?.tableView.reloadData()
			// If screen size is big enough to contain first batch of posts, fetch and show next batch of posts.
			if let tableView = self?.tableView {
				self?.scrollViewDidScroll(tableView)
			}
		}

		viewModel.onError = { [weak self] error in
			self?.showErrorAlert(error: error)
		}
	}

	private func showErrorAlert(error: Error) {
		let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
		alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
		present(alert, animated: true, completion: nil)
	}
}

extension PostsViewController: UITableViewDataSource, UITableViewDelegate {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return viewModel.numberOfPosts()
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(withIdentifier: PostTableViewCell.reuseIdentifier, for: indexPath) as? PostTableViewCell else {
			fatalError("Please check cell identifier")
		}
		let post = viewModel.post(at: indexPath.row)
		cell.configure(with: post, computedDetail: "Loading...")
		cell.tag = indexPath.row
		heavyComputationHelper.heavyComputation(for: post) { value in
			DispatchQueue.main.async {
				if cell.tag == indexPath.row {
					cell.configure(with: post, computedDetail: value)
				}
			}
		}
		return cell
	}

	func scrollViewDidScroll(_ scrollView: UIScrollView) {
		let offsetY = scrollView.contentOffset.y
		let contentHeight = scrollView.contentSize.height
		let height = scrollView.frame.size.height

		if offsetY > contentHeight - height, viewModel.isNextBatchAvailable  {
			viewModel.fetchPosts()
		}
	}

	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let post = viewModel.post(at: indexPath.row)
		let detailViewController = DetailViewController()
		detailViewController.post = post
		navigationController?.pushViewController(detailViewController, animated: true)
		tableView.deselectRow(at: indexPath, animated: true)
	}
}

