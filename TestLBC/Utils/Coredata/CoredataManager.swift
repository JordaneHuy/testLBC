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

    // MARK: Core Data Stack
    
    lazy var persistentContainer: NSPersistentContainer = {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer
    }()
    
    // MARK: Core Data CRUD
    
    func insertCategories(categories: [Category]) {
        deleteCategories()
        categories.forEach { createCategory(category: $0) }
        
    }
    
    func createCategory(category: Category) {
        let context = persistentContainer.viewContext
        
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
        // Initialize Fetch Request
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "CDCategory")

        // Configure Fetch Request
        fetchRequest.includesPropertyValues = false
        
        do {
            let results = try persistentContainer.viewContext.fetch(fetchRequest)
            for object in results {
                guard let objectData = object as? NSManagedObject else {continue}
                persistentContainer.viewContext.delete(objectData)
            }
        } catch let error {
            print(error)
        }
    }
    
    func fetchCategory(id: Int) -> CDCategory? {
        let categoriesFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "CDCategory")
        categoriesFetch.predicate = NSPredicate(format: "id == %i", id)
         
        do {
            let fetchedCategories = try persistentContainer.viewContext.fetch(categoriesFetch) as! [CDCategory]
            
            if fetchedCategories.count > 0 {
                return fetchedCategories.first
            }
            
            return nil
        } catch {
            fatalError("Failed to fetch employees: \(error)")
        }
    }
}
