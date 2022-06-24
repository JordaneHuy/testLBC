//
//  DetailViewModel.swift
//  TestLBC
//
//  Created by Jordane HUY on 22/06/2022.
//

import Foundation

class DetailViewModel {
    // MARK: Properties
    weak var appCoordinator : AppCoordinator?
    
    // MARK: Init
    
    init(appCoordinator: AppCoordinator) {
        self.appCoordinator = appCoordinator
    }
    
    // MARK: Methods
    
    func pushToHome(){
        appCoordinator?.pushToDetail()
    }
}
