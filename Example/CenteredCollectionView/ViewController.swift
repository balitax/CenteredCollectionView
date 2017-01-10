//
//  ViewController.swift
//  Example
//
//  Created by Benjamin Emdon on 2016-12-28.
//  Copyright © 2016 Benjamin Emdon. 
//

import UIKit
import CenteredCollectionView

class ViewController: UIViewController {

	let centeredCollectionView = CenteredCollectionView()
	let controlCenter = ControlCenterView()
	let cellPercentWidth: CGFloat = 0.7

	override func viewDidLoad() {
		super.viewDidLoad()
		title = "CenteredCollectionView"

		view.backgroundColor = UIColor.lightGray
		centeredCollectionView.backgroundColor = UIColor.clear

		// delegate & data source
		controlCenter.delegate = self
		centeredCollectionView.delegate = self
		centeredCollectionView.dataSource = self

		let gradient = CAGradientLayer()
		gradient.frame = view.bounds
		gradient.locations = [0, 1]
		gradient.startPoint = CGPoint(x: 0, y: 0)
		gradient.endPoint = CGPoint(x: 1, y: 1)
		gradient.colors = [
			UIColor(colorLiteralRed: 1, green: 0.5764705882, blue: 0.5843137255, alpha: 1).cgColor,
			UIColor(colorLiteralRed: 1, green: 0.5764705882, blue: 0.462745098, alpha: 1).cgColor
		]
		view.layer.insertSublayer(gradient, at: 0)

		// layout subviews
		let stackView = UIStackView()
		stackView.axis = .vertical

		stackView.addArrangedSubview(centeredCollectionView)
		stackView.addArrangedSubview(controlCenter)

		view.addSubview(stackView)
		stackView.translatesAutoresizingMaskIntoConstraints = false

		NSLayoutConstraint.activate([
			stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			stackView.topAnchor.constraint(equalTo: view.topAnchor),
			stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
			])

		// register collection cells
		centeredCollectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: String(describing: CollectionViewCell.self))

		// configure layout
		centeredCollectionView.itemSize = CGSize(width: view.bounds.width * cellPercentWidth, height: view.bounds.height * cellPercentWidth * cellPercentWidth )
		centeredCollectionView.minimumLineSpacing = 20
		centeredCollectionView.showsVerticalScrollIndicator = false
		centeredCollectionView.showsHorizontalScrollIndicator = false
	}
}

extension ViewController: ControlCenterViewDelegate {
	func stateChanged(scrollDirection: UICollectionViewScrollDirection) {
		centeredCollectionView.scrollDirection = scrollDirection
	}

	func stateChanged(scrollToEnabled: Bool) {
		centeredCollectionView.scrollToEdgeEnabled = scrollToEnabled
	}
}

extension ViewController: UICollectionViewDelegate {
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		print("Selected Cell #\(indexPath.row)")
	}
}

extension ViewController: UICollectionViewDataSource {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return 6
	}

	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: CollectionViewCell.self), for: indexPath) as! CollectionViewCell
		cell.titleLabel.text = "Cell #\(indexPath.row)"
		return cell
	}
}
