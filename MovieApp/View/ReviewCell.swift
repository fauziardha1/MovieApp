//
//  ReviewCell.swift
//  MovieApp
//
//  Created by FauziArda on 11/01/23.
//

import Foundation
import UIKit

class ReviewCell: UITableViewCell {
    static let  id = "ReviewCellID"
    
    lazy var iconImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 100
        return imageView
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 20)
        label.textColor = .black
        return label
    }()
    
    lazy var descLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 17)
        label.numberOfLines = 0
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(iconImage)
        addSubview(titleLabel)
        addSubview(descLabel)
        backgroundColor = UIColor(red: 0.77, green: 0.87, blue: 0.96, alpha: 1.00)
        
        NSLayoutConstraint.activate([
            // icon
            iconImage.leadingAnchor.constraint(equalTo: leadingAnchor),
            iconImage.topAnchor.constraint(equalTo: topAnchor),
            iconImage.widthAnchor.constraint(equalToConstant: 50),
            iconImage.heightAnchor.constraint(equalToConstant: 50),
            // title
            titleLabel.leadingAnchor.constraint(equalTo: iconImage.trailingAnchor, constant: 8),
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 30),
            // description
            descLabel.leadingAnchor.constraint(equalTo: iconImage.trailingAnchor, constant: 8),
            descLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor,constant: 8),
            descLabel.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -16),
            descLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
