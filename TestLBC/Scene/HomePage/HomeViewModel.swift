//
//  HomeViewModel.swift
//  TestLBC
//
//  Created by Jordane HUY on 22/06/2022.
//

import Foundation

class HomeViewModel {
    weak var appCoordinator : AppCoordinator?
    
    init(appCoordinator: AppCoordinator) {
        self.appCoordinator = appCoordinator
    }
    
    func pushToDetail(){
        appCoordinator?.pushToDetail()
    }
}
