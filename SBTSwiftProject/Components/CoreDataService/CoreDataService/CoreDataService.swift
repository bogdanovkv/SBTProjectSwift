//
//  CoreDataService.swift
//  SBTSwiftProject
//
//  Created by Константин Богданов on 11.04.2021.
//  Copyright © 2021 Константин Богданов. All rights reserved.
//

import CoreData
import DatabaseAbstraction
import Foundation

/// Сервис работы с CoreData
public final class CoreDataService: DatabaseServiceProtocol {

	private let persistentCntainer: NSPersistentContainer
	private var viewContext: NSManagedObjectContext {
		return persistentCntainer.viewContext
	}

	private lazy var backgroundContext = {
		return persistentCntainer.newBackgroundContext()
	}()

	init(persistentContainer: NSPersistentContainer) {
		self.persistentCntainer = persistentContainer
	}

	public convenience init() {
		let bundle = Bundle(for: type(of: self))
		let modelURL = bundle.url(forResource: "CoreDataService", withExtension: ".momd")!
		guard let model = NSManagedObjectModel(contentsOf: modelURL) else {
			let container = NSPersistentContainer(name: "CoreDataService")
			self.init(persistentContainer: container)
			return
		}
		let container = NSPersistentContainer(name: "CoreDataService", managedObjectModel: model)
		container.loadPersistentStores(completionHandler: { _, _ in })
		self.init(persistentContainer: container)
	}

	public func fetch<Model>(storeId: String, convertClosure: (StoredObjectProtocol) -> Model?) -> [Model] {
		var result: [Model] = []
		viewContext.performAndWait {
			let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: storeId)
			let managedResult = (try? fetchRequest.execute()) ?? []
			result = managedResult.compactMap(convertClosure)
		}
		return result
	}

	public func fetch<Model>(storeId: String,
					  convertClosure: (StoredObjectProtocol) -> Model?,
					  predicate: [String : String]) -> [Model] {
		var result: [Model] = []
		viewContext.performAndWait {
			let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: storeId)
			let nsPredicate = NSPredicate(format: predicate.reduce("", { $0 + "\($1.key) = %@ " }), argumentArray: predicate.map({ $1 }))
			fetchRequest.predicate = nsPredicate
			let managedResult = (try? fetchRequest.execute()) ?? []
			result = managedResult.compactMap(convertClosure)
		}
		return result
	}

	public func insert<Model>(storeId: String, models: [Model], convertClosure: @escaping (Model, StoredObjectProtocol) -> Void, completion: @escaping () -> Void) {
		let context = backgroundContext
		context.perform {
			models.forEach { model in
				let entity = NSEntityDescription.insertNewObject(forEntityName: storeId, into: context)

				convertClosure(model, entity)
			}
			try? context.save()
			completion()
		}
	}

	public func deleteAll(storeId: String, completion: @escaping () -> Void) {
		let context = backgroundContext
		context.perform {

			let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: storeId)
			(try? fetchRequest.execute())?.forEach({ context.delete($0) })
			completion()
		}
	}
}
