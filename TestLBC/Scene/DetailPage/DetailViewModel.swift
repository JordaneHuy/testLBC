//
//  DetailViewModel.swift
//  TestLBC
//
//  Created by Jordane HUY on 22/06/2022.
//

import Foundation
import Combine

class DetailViewModel {
    // MARK: Properties
    weak var appCoordinator : AppCoordinator?
    
    @Published var item: Item
    
    // MARK: Init
    
    init(appCoordinator: AppCoordinator, item: Item) {
        self.appCoordinator = appCoordinator
        self.item = item
    }
}
