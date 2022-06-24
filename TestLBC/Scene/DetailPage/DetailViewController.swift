//
//  DetailViewController.swift
//  TestLBC
//
//  Created by Jordane HUY on 22/06/2022.
//

import UIKit

class DetailViewController: UIViewController {
    // MARK: Properties
    
    var viewModel : DetailViewModel

    // MARK: Init
    
    init(viewModel: DetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .yellow

        // Do any additional setup after loading the view.
    }
}
