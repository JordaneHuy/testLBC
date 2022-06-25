//
//  DetailViewController.swift
//  TestLBC
//
//  Created by Jordane HUY on 22/06/2022.
//

import UIKit
import Combine

class DetailViewController: UIViewController {
    // MARK: Properties
    
    var viewModel : DetailViewModel
    var subscriptions = Set<AnyCancellable>()
    
    // MARK: UI Components
    
    private let scrollView: UIScrollView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.contentInset.bottom = 50
        return $0
    }(UIScrollView())
    
    private let scrollStackView: UIStackView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.axis = .vertical
        $0.spacing = 0
        return $0
    }(UIStackView())
    
    private let imageView: UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = UIColor(red: 250/255, green: 250/255, blue: 250/255, alpha: 1)
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        return $0
    }(UIImageView())
    
    private let descriptionView: UIView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIView())
    
    private let titleLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = UIFont(name: "Avenir-Heavy", size: 20)
        $0.textColor = .black
        $0.numberOfLines = 3
        return $0
    }(UILabel())
    
    private let descriptionLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = UIFont(name: "Avenir-Medium", size: 16)
        $0.textColor = .black
        $0.numberOfLines = 0
        return $0
    }(UILabel())
    
    private let categoryLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = UIFont(name: "Avenir-Medium", size: 16)
        $0.textColor = .gray
        return $0
    }(UILabel())
    
    private let urgentLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = UIFont(name: "Avenir-Medium", size: 12)
        $0.text = "• Urgent"
        $0.textColor = .systemPink
        $0.layer.masksToBounds = true
        $0.layer.cornerRadius = 5
        $0.isHidden = true
        return $0
    }(UILabel())
    
    private let priceButton: UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = .orange
        $0.setTitleColor(.white, for: .normal)
        $0.setImage(UIImage(systemName: "cart"), for: .normal)
        $0.tintColor = .white
        $0.layer.masksToBounds = true
        $0.layer.cornerRadius = 10
        $0.contentEdgeInsets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        return $0
    }(UIButton())
    
    private let dateLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = UIFont(name: "Avenir-Light", size: 12)
        $0.textColor = .black
        return $0
    }(UILabel())
    
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
        // Do any additional setup after loading the view.
        
        configureView()
        configureLayout()
        
        itemSubscription()
    }
    
    // MARK: View Configuration
    
    func configureView() {
        title = "Detail"
        view.backgroundColor = UIColor(red: 250/255, green: 250/255, blue: 250/255, alpha: 1)
        view.addSubview(scrollView)
        view.addSubview(priceButton)

        scrollView.addSubview(scrollStackView)
        scrollStackView.addArrangedSubview(imageView)
        scrollStackView.addArrangedSubview(descriptionView)
        
        descriptionView.addSubview(categoryLabel)
        descriptionLabel.addSubview(urgentLabel)
        descriptionView.addSubview(titleLabel)
        descriptionView.addSubview(descriptionLabel)
        descriptionView.addSubview(dateLabel)
    }
    
    func configureLayout() {
        // scrollView constraints
        scrollView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        scrollView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        // price constraint
        priceButton.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -16).isActive = true
        priceButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16).isActive = true
        
        // stackview constraints
        scrollStackView.leftAnchor.constraint(equalTo: scrollView.leftAnchor).isActive = true
        scrollStackView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        scrollStackView.rightAnchor.constraint(equalTo: scrollView.rightAnchor).isActive = true
        scrollStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        scrollStackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        
        // imageview constraints
        imageView.heightAnchor.constraint(equalToConstant: 320).isActive = true
        
        // category constraints
        categoryLabel.leftAnchor.constraint(equalTo: descriptionView.leftAnchor, constant: 8).isActive = true
        categoryLabel.topAnchor.constraint(equalTo: descriptionView.topAnchor, constant: 8).isActive = true
        
        // urgent constraints
        urgentLabel.leftAnchor.constraint(equalTo: categoryLabel.rightAnchor, constant: 8).isActive = true
        urgentLabel.centerYAnchor.constraint(equalTo: categoryLabel.centerYAnchor).isActive = true
        
        // title constraints
        titleLabel.leftAnchor.constraint(equalTo: descriptionView.leftAnchor, constant: 8).isActive = true
        titleLabel.topAnchor.constraint(equalTo: categoryLabel.bottomAnchor, constant: 8).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: descriptionView.rightAnchor, constant: -8).isActive = true
        
        // description constraints
        descriptionLabel.leftAnchor.constraint(equalTo: descriptionView.leftAnchor, constant: 8).isActive = true
        descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8).isActive = true
        descriptionLabel.rightAnchor.constraint(equalTo: descriptionView.rightAnchor, constant: -8).isActive = true
        
        // date constraints
        dateLabel.leftAnchor.constraint(equalTo: descriptionView.leftAnchor, constant: 8).isActive = true
        dateLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 8).isActive = true
        dateLabel.rightAnchor.constraint(equalTo: descriptionView.rightAnchor, constant: -8).isActive = true
        dateLabel.bottomAnchor.constraint(equalTo: descriptionView.bottomAnchor).isActive = true
    }
    
    func configureItem(item: Item) {
        if let imageUrl = item.images.small {
            imageView.loadRemoteImageFrom(urlString: imageUrl)
        }
        
        titleLabel.text = item.title
        descriptionLabel.text = item.description
        categoryLabel.text = item.category?.name
        priceButton.setTitle(String(format: " %.02f €", item.price), for: .normal)
        
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.locale = Locale(identifier: "fr_FR")

        dateLabel.text = "Créé le \(formatter.string(from: item.creationDate))"
        urgentLabel.isHidden = !item.isUrgent
    }
    
    // MARK: - Subscription
    
    func itemSubscription() {
        viewModel.$item
           .receive(on: DispatchQueue.main)
           .sink { [weak self] item in
               self?.configureItem(item: item)
           }
           .store(in: &subscriptions)
    }
}
