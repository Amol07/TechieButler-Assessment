//
//  UIView.Extensions.swift
//  TechieButler-Assessment
//
//  Created by Amol Prakash on 29/05/24.
//

import UIKit

/// Extends the `UIView` class to add a `pinToSuperview()` method.
///
/// This method pins the view to its superview by setting its `translatesAutoresizingMaskIntoConstraints` property to `false` and activating leading, trailing, top, and bottom constraints to the superview.
extension UIView {
	func pinToSuperview() {
		guard let superview = superview else { return }
		translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			leadingAnchor.constraint(equalTo: superview.leadingAnchor),
			trailingAnchor.constraint(equalTo: superview.trailingAnchor),
			topAnchor.constraint(equalTo: superview.topAnchor),
			bottomAnchor.constraint(equalTo: superview.bottomAnchor)
		])
	}
}
