//
//  ViewController.swift
//  SBTSwiftProject
//
//  Created by Константин Богданов on 14.07.2018.
//  Copyright © 2018 Константин Богданов. All rights reserved.
//

import UIKit

final class LocationViewController: UIViewController {
	let location = LocationRepository(networkService: NetworkService(sesion: .shared))
	private lazy var locationView: LocationViewInput = LocationView()
	private let interactor: LocationInteractorInput

	init(interactor: LocationInteractorInput) {
		self.interactor = interactor
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func loadView() {
		view = locationView
	}

    override func viewDidLoad() {
        super.viewDidLoad()
		interactor.getLocation()
	}
}

extension LocationViewController: LocationInteractorOutput {
	func didUpdateLocation(_ location: LocationModel) {
		locationView.set(location: location)
	}

	func didRecieveError() {

	}
}
