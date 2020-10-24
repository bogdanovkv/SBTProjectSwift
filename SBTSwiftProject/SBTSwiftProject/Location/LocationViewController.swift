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

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.green
	}
}

