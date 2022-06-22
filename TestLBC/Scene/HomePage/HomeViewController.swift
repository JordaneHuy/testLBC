//
//  ViewController.swift
//  TestLBC
//
//  Created by Jordane HUY on 20/06/2022.
//

import UIKit

class HomeViewController: UIViewController {
    var viewModel : HomeViewModel
    
    // MARK: UI Components
    
    private let testbutton: UIButton = {
        $0.addTarget(self, action: #selector(testPush), for: .touchUpInside)
        $0.frame = CGRect(x: 100, y: 100, width: 100, height: 100)
        $0.setTitle("popopo", for: .normal)
        return $0
    }(UIButton())

    // MARK: Init
    
    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        configureView()
        configureLayout()
        self.view.backgroundColor = .blue
        
        HomeWorker().getListing(completion: { items, error in
            print(items)
        })
    }
    
    // MARK: View Configuration
    
    func configureView() {
        view.addSubview(testbutton)
    }
    
    func configureLayout() {
        
    }
    
    // MARK: Action
    
    @objc func testPush() {
        viewModel.pushToDetail()
    }
}

