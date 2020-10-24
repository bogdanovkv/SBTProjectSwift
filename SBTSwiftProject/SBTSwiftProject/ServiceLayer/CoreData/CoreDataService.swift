//
//  CoreDataService.swift
//  SBTSwiftProject
//
//  Created by Константин Богданов on 24.10.2020.
//  Copyright © 2020 Константин Богданов. All rights reserved.
//

import CoreData

protocol CoreDataServiceProtocol {
	func fetch<Entity: NSManagedObject, Model>(convertClosure: (Entity) -> Model) -> [Model]
	func insert<Model, Entity: NSManagedObject>(models: [Model],
												convertClosure: @escaping (Model, Entity) -> Void,
												completion: @escaping () -> Void)
}

final class CoreDataService: CoreDataServiceProtocol {
	private let persistentCntainer: NSPersistentContainer
	private var viewContext: NSManagedObjectContext {
		return persistentCntainer.viewContext
	}

	private lazy var backgroundContext = {
		return persistentCntainer.newBackgroundContext()
	}()

	init(persistentCntainer: NSPersistentContainer) {
		self.persistentCntainer = persistentCntainer
	}

	convenience init() {
        let container = NSPersistentContainer(name: "SBTSwiftProject")
        container.loadPersistentStores(completionHandler: { _, _ in })
		self.init(persistentCntainer: container)
	}

	func fetch<Entity: NSManagedObject, Model>(convertClosure: (Entity) -> Model) -> [Model] {
		var result: [Entity] = []
		viewContext.performAndWait {
			let fetchRequest = NSFetchRequest<Entity>()
			result = (try? fetchRequest.execute()) ?? []
		}
		return result.map(convertClosure)
	}

	func insert<Model, Entity: NSManagedObject>(models: [Model],
												convertClosure: @escaping (Model, Entity) -> Void,
												completion: @escaping () -> Void) {
		backgroundContext.perform { [weak self] in
			guard let self = self else { return }
			models.forEach { model in
				let entity = Entity(context: self.backgroundContext)
				convertClosure(model, entity)
			}
			try? self.backgroundContext.save()
			completion()
		}
	}
}
