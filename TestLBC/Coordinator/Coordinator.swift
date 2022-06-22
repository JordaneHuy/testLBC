//
//  Coordinator.swift
//  TestLBC
//
//  Created by Jordane HUY on 22/06/2022.
//

import Foundation
import UIKit

protocol Coordinator {
    var parentCoordinator: Coordinator? { get set }
    var children: [Coordinator] { get set }
    var navigationController : UINavigationController { get set }
    
    func start()
}
