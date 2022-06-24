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
    
    var subscriptions = [AnyCancellable]()
    
    // MARK: Init
    
    init(appCoordinator: AppCoordinator) {
        self.appCoordinator = appCoordinator
        
        getListing()
    }
    
    func getListing() {
        HomeWorker().getListing { [weak self] items, error in
            guard let items = items else {
                return
            }
            
            self?.items = items
        }
    }
    
    // MARK: Methods
    
    func pushToDetail(){
        appCoordinator?.pushToDetail()
    }
}
