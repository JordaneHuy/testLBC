//
//  DetailViewModel.swift
//  TestLBC
//
//  Created by Jordane HUY on 22/06/2022.
//

import Foundation

class DetailViewModel {
    weak var appCoordinator : AppCoordinator?
    
    init(appCoordinator: AppCoordinator) {
        self.appCoordinator = appCoordinator
    }
    
    func pushToHome(){
        appCoordinator?.pushToDetail()
    }
}
