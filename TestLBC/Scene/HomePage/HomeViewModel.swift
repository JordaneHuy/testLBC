//
//  HomeViewModel.swift
//  TestLBC
//
//  Created by Jordane HUY on 22/06/2022.
//

import Foundation
import CoreData
import Combine


class HomeViewModel {
    // MARK: Properties
    weak var appCoordinator : AppCoordinator?
    
    @Published var items: [Item] = []
        
    // MARK: Init
    
    init(appCoordinator: AppCoordinator) {
        self.appCoordinator = appCoordinator
        
        getCategories() { [weak self] in
            self?.getListing()
        }
    }
    
    // MARK: Methods
    
    func getListing() {
        HomeWorker().getListing { [weak self] items, response, error in
            guard let items = items else { return }
            self?.items = items
        }
    }
    
    func getCategories(completion: @escaping () -> ()) {
        HomeWorker().getCategories { categories, response, error in
            guard let categories = categories else { return }
            CoreDataManager.shared.insertCategories(categories: categories)
            completion()
        }
    }
    
    // MARK: Coordinator
    
    func pushToDetail(itemRow: Int) {
        let item = items[itemRow]
        appCoordinator?.pushToDetail(item: item)
    }
}
