//
//  ViewController.swift
//  TestLBC
//
//  Created by Jordane HUY on 20/06/2022.
//

import UIKit
import CoreData
import Combine

class HomeViewController: UIViewController {
    // MARK: Properties

    var viewModel : HomeViewModel
    var subscriptions = Set<AnyCancellable>()
    
    // MARK: UI Components
    
    private let testbutton: UIButton = {
        $0.addTarget(self, action: #selector(testPush), for: .touchUpInside)
        $0.frame = CGRect(x: 100, y: 100, width: 100, height: 100)
        $0.setTitle("popopo", for: .normal)
        return $0
    }(UIButton())
    
    private let tableView: UITableView = UITableView()

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
        
        self.title = "test ninja"
        
        configureView()
        configureLayout()
        self.view.backgroundColor = UIColor(red: 250/255, green: 250/255, blue: 250/255, alpha: 1)
        
        viewModel.$items
           .receive(on: DispatchQueue.main)
           .sink { [weak self] items in
              self?.tableView.reloadData()
           }
           .store(in: &subscriptions)
        /*
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "CDCategory", in: context)
        let newUser = NSManagedObject(entity: entity!, insertInto: context)
        newUser.setValue(1, forKey: "id")
        newUser.setValue("popo", forKey: "name")
        
        do {
            try context.save()
        } catch {
            
        }*/
        
        //let coreDataManager = CoreDataManager(modelName: "CDCategory")
        /*
        HomeWorker().getCategories(completion: { categories, error in
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            let entity = NSEntityDescription.entity(forEntityName: "Users", in: context)
            let newUser = NSManagedObject(entity: entity!, insertInto: context)
            

            print(categories)
        })*/
        /*
        HomeWorker().getListing(completion: { items, error in
            print(items)
        })*/
    }
    
    // MARK: View Configuration
    
    func configureView() {
        view.addSubview(tableView)
        configureTableView()
    }
    
    func configureLayout() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        let leadingConstraint = tableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor)
        let topConstraint = tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        let trailingConstraint = tableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor)
        let bottomConstraint = tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        view.addConstraints([leadingConstraint, topConstraint, trailingConstraint, bottomConstraint])
    }
    
    func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none

    }
    
    // MARK: Action
    
    @objc func testPush() {
        viewModel.pushToDetail()
    }
}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("popo")
    }
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ItemTableViewCell()
        cell.configure(item: viewModel.items[indexPath.row])
        return cell
    }
}
