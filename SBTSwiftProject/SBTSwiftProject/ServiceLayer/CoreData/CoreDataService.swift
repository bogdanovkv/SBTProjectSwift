//
//  CoreDataService.swift
//  SBTSwiftProject
//
//  Created by Константин Богданов on 24.10.2020.
//  Copyright © 2020 Константин Богданов. All rights reserved.
//

import CoreData

/// Сервис работы с CoreData
protocol CoreDataServiceProtocol {

	/// Извлекает модели из CoreData
	/// - Parameter convertClosure: блок для преобразования managed модели в обычную
	func fetch<Entity: NSManagedObject, Model>(convertClosure: (Entity) -> Model?) -> [Model]

	/// Извлекает модели из CoreData
	/// - Parameters:
	///   - convertClosure: блок для преобразования managed модели в обычную
	///   - predicate: предикат для выборки моделей
	func fetch<Entity: NSManagedObject, Model>(convertClosure: (Entity) -> Model?,
											   predicate: NSPredicate) -> [Model]

	/// Добавить модели в CoreData
	/// - Parameters:
	///   - models: модели
	///   - convertClosure: блок, в котором происходит установка свойст managed модели
	///   - completion: блок, выполняющийся по завершению сохранения моделей
	func insert<Model, Entity: NSManagedObject>(models: [Model],
												convertClosure: @escaping (Model, Entity) -> Void,
												completion: @escaping () -> Void)

	/// Удаляет все сущности данного типа из CoreData
	/// - Parameter type: тип
	func deleteAll<Entity: NSManagedObject>(type: Entity.Type)
}

protocol Container {
	var name: String { get }
}

extension NSPersistentContainer: Container {}

/// Сервис работы с CoreData
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

	func fetch<Entity: NSManagedObject, Model>(convertClosure: (Entity) -> Model?) -> [Model] {
		var result: [Model] = []
		viewContext.performAndWait {
			let fetchRequest = NSFetchRequest<Entity>(entityName: NSStringFromClass(Entity.self))
			let managedResult = (try? fetchRequest.execute()) ?? []
			result = managedResult.compactMap(convertClosure)
		}
		return result
	}

	func fetch<Entity: NSManagedObject, Model>(convertClosure: (Entity) -> Model?,
											   predicate: NSPredicate) -> [Model] {
		var result: [Model] = []
		viewContext.performAndWait {
			let fetchRequest = NSFetchRequest<Entity>(entityName: NSStringFromClass(Entity.self))
			fetchRequest.predicate = predicate
			let managedResult = (try? fetchRequest.execute()) ?? []
			result = managedResult.compactMap(convertClosure)
		}
		return result
	}

	func insert<Model, Entity: NSManagedObject>(models: [Model],
												convertClosure: @escaping (Model, Entity) -> Void,
												completion: @escaping () -> Void) {
		let context = backgroundContext
		context.perform {
			models.forEach { model in
				let entity = Entity(context: self.backgroundContext)
				convertClosure(model, entity)
			}
			try? context.save()
			completion()
		}
	}

	func deleteAll<Entity: NSManagedObject>(type: Entity.Type) {
		let context = backgroundContext
		context.perform {
			let request = NSFetchRequest<Entity>(entityName: NSStringFromClass(Entity.self))
			let objects = try? request.execute()
			objects?.forEach({ context.delete($0) })
			try? context.save()
		}
	}
}