//
//  ItemTableViewCell.swift
//  TestLBC
//
//  Created by Jordane HUY on 24/06/2022.
//

import UIKit

class ItemTableViewCell: UITableViewCell {
    
    // MARK: UI Components
    
    private let containerView: UIView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.layer.masksToBounds = false
        $0.layer.cornerRadius = 5
        $0.backgroundColor = .white
        $0.layer.shadowColor = UIColor.black.cgColor
        $0.layer.shadowOffset = CGSize(width: 0.0, height: 3.0)
        $0.layer.shadowOpacity = 0.1
        $0.layer.shadowRadius = 3
        
        return $0
    }(UIView())
    
    private let thumbImageView: UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.layer.masksToBounds = true
        $0.layer.cornerRadius = 5
        $0.backgroundColor = UIColor(red: 250/255, green: 250/255, blue: 250/255, alpha: 1)
        $0.contentMode = .scaleAspectFill
        return $0
    }(UIImageView())
    
    private let titleLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = UIFont(name: "Avenir-Medium", size: 16)
        $0.textColor = .black
        $0.numberOfLines = 3
        return $0
    }(UILabel())
    
    private let categoryLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = UIFont(name: "Avenir-Medium", size: 12)
        $0.textColor = .gray
        return $0
    }(UILabel())
    
    private let priceLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = UIFont(name: "Avenir-Heavy", size: 20)
        $0.textColor = .black
        return $0
    }(UILabel())
    
    private let urgentImage: UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.isHidden = true
        $0.image = UIImage(systemName: "exclamationmark.circle.fill")
        $0.tintColor = .red
        $0.contentMode = .scaleAspectFill
        return $0
    }(UIImageView())
    
    // MARK: Init

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureView()
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: View Configuration
    
    private func configureView() {
        selectionStyle = .none
        contentView.backgroundColor = UIColor(red: 250/255, green: 250/255, blue: 250/255, alpha: 1)
        
        contentView.addSubview(containerView)
        containerView.addSubview(thumbImageView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(categoryLabel)
        containerView.addSubview(priceLabel)
        containerView.addSubview(urgentImage)
    }
    
    private func configureLayout() {
        // containerView constraints
        containerView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16).isActive = true
        containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8).isActive = true
        containerView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16).isActive = true
        containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8).isActive = true
        
        // thumbnail constraints
        thumbImageView.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 8).isActive = true
        thumbImageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 8).isActive = true
        thumbImageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -8).isActive = true
        thumbImageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        thumbImageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        // title contraints
        titleLabel.leftAnchor.constraint(equalTo: thumbImageView.rightAnchor, constant: 8).isActive = true
        titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 8).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -8).isActive = true
        
        // category contraints
        categoryLabel.leftAnchor.constraint(equalTo: thumbImageView.rightAnchor, constant: 8).isActive = true
        categoryLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor).isActive = true
        
        // price contraints
        priceLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -8).isActive = true
        priceLabel.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -8).isActive = true
        
        // urgent contraints
        urgentImage.topAnchor.constraint(equalTo: containerView.topAnchor, constant: -8).isActive = true
        urgentImage.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -8).isActive = true
        urgentImage.widthAnchor.constraint(equalToConstant: 20).isActive = true
        urgentImage.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }
    
    func configure(item: Item) {
        titleLabel.text = item.title
        priceLabel.text = String(format: "%.02f €", item.price)
        
        if let thumbnailUrl = item.images.small {
            thumbImageView.loadRemoteImageFrom(urlString: thumbnailUrl)
        }
        
        if let category = item.category {
            categoryLabel.text = "\(category.name)"
        }
        
        urgentImage.isHidden = !item.isUrgent
    }
}
