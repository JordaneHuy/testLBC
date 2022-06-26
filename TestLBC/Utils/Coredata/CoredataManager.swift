//
//  CoredataManager.swift
//  TestLBC
//
//  Created by Jordane HUY on 23/06/2022.
//

import Foundation
import CoreData
import UIKit

public class CoreDataManager {

    // MARK: Properties

    public static let shared = CoreDataManager()
    var testing: Bool = false

    // MARK: Core Data Stack
    
    lazy var persistentContainer: NSPersistentContainer = {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer
    }()
    
    lazy var mockPersistantContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "PersistentTest", managedObjectModel: self.mockManagedObjectModel)
        let description = NSPersistentStoreDescription()
        description.type = NSInMemoryStoreType
        description.shouldAddStoreAsynchronously = false // Make it simpler in test env
        
        container.persistentStoreDescriptions = [description]
        container.loadPersistentStores { (description, error) in
            // Check if the data store is in memory
            precondition( description.type == NSInMemoryStoreType )
                                        
            // Check if creating container wrong
            if let error = error {
                fatalError("Create an in-mem coordinator failed \(error)")
            }
        }
        return container
    }()
    
    lazy var mockManagedObjectModel: NSManagedObjectModel = {
        let managedObjectModel = NSManagedObjectModel.mergedModel(from: [Bundle(for: type(of: self))] )!
        return managedObjectModel
    }()
    
    // MARK: Core Data CRUD
    
    func insertCategories(categories: [Category]) {
        deleteCategories()
        categories.forEach { createCategory(category: $0) }
    }
    
    func createCategory(category: Category) {
        let context = !testing ? persistentContainer.viewContext : mockPersistantContainer.viewContext
        
        let cdCategory = NSEntityDescription.insertNewObject(forEntityName: "CDCategory", into: context) as! CDCategory
        
        cdCategory.id = Int64(category.id)
        cdCategory.name = category.name
        
        do {
            try context.save()
        } catch let error {
            print(error)
        }
    }
    
    func deleteCategories() {
        let context = !testing ? persistentContainer.viewContext : mockPersistantContainer.viewContext
        
        // Initialize Fetch Request
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "CDCategory")

        // Configure Fetch Request
        fetchRequest.includesPropertyValues = false
        
        do {
            let results = try context.fetch(fetchRequest)
            for object in results {
                guard let objectData = object as? NSManagedObject else {continue}
                context.delete(objectData)
            }
        } catch let error {
            print(error)
        }
    }
    
    func fetchCategory(id: Int) -> CDCategory? {
        let context = !testing ? persistentContainer.viewContext : mockPersistantContainer.viewContext
        let categoriesFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "CDCategory")
        categoriesFetch.predicate = NSPredicate(format: "id == %i", id)
         
        do {
            let fetchedCategories = try context.fetch(categoriesFetch) as! [CDCategory]
            
            if fetchedCategories.count > 0 {
                return fetchedCategories.first
            }
            
            return nil
        } catch {
            fatalError("Failed to fetch employees: \(error)")
        }
    }
}
