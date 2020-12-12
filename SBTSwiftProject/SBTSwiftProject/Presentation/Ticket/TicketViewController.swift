//
//  TicketViewController.swift
//  SBTSwiftProject
//
//  Created by Константин Богданов on 21.11.2020.
//  Copyright © 2020 Константин Богданов. All rights reserved.
//

import UIKit

/// Контролллер для отображения билета
final class TicketViewController: UIViewController {

	private let viewModel: TicketViewModel

	init(viewModel: TicketViewModel) {
		self.viewModel = viewModel
		super.init(nibName: nil, bundle: nil)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func loadView() {
		view = TicketView()
	}

	override func viewDidLoad() {
		super.viewDidLoad()
	}

	private func updateView() {

	}
}
