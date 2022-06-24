//
//  AppCoordinator.swift
//  TestLBC
//
//  Created by Jordane HUY on 22/06/2022.
//

import Foundation
import UIKit

class AppCoordinator: Coordinator {
    var parentCoordinator: Coordinator?
    var children: [Coordinator] = []
    var navigationController: UINavigationController
    
    init(navCon : UINavigationController) {
        self.navigationController = navCon
    }
    
    func start() {
        pushToHome()
    }
    
    func pushToHome() {
        let homeViewModel = HomeViewModel.init(appCoordinator: self)
        let homeViewController = HomeViewController(viewModel: homeViewModel)
        
        navigationController.pushViewController(homeViewController, animated: true)
    }
    
    func pushToDetail(item: Item) {
        let detailViewModel = DetailViewModel.init(appCoordinator: self, item: item)
        let detailViewController = DetailViewController(viewModel: detailViewModel)
        
        navigationController.pushViewController(detailViewController, animated: true)
    }
}
