//
//  MovieCardCollectionViewCell.swift
//  MovieApp
//
//  Created by FauziArda on 11/01/23.
//

import UIKit

class MovieCardCollectionViewCell: UICollectionViewCell {
    static let identifier = "TextItemCell"
    
    lazy var imageView : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var movieName : UILabel = {
        let label = UILabel()
        
        label.text = "Movie 1"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = .black
        label.numberOfLines = 2
        label.font = UIFont.boldSystemFont(ofSize: 12.0)
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageView)
        contentView.addSubview(movieName)
        contentView.backgroundColor = .systemRed
        contentView.layer.cornerRadius = 12
        
       
        
        imageView.image = UIImage(systemName: "film.fill")
        imageView.tintColor = .white
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            imageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            imageView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.8),
            imageView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.8),
            
            
            movieName.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 4),
            movieName.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            movieName.widthAnchor.constraint(equalTo: contentView.widthAnchor)
            
            
        ])
        
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = contentView.bounds
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
//        imageView.image = nil
    }
}


extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}

extension UICollectionView {
    

    func setEmptyMessage(_ message: String) {
        let view = UIView()
        
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        messageLabel.text = message
        messageLabel.textColor = .black
        messageLabel.numberOfLines = 0;
        messageLabel.textAlignment = .center;
        messageLabel.font = UIFont(name: "TrebuchetMS", size: 15)
        messageLabel.sizeToFit()
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let imageView : UIImageView = {
            let imageView = UIImageView()
            imageView.contentMode = .scaleAspectFit
            imageView.clipsToBounds = true
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.image = UIImage(systemName: "wifi.exclamationmark")
            return imageView
        }()
        
        
        view.addSubview(messageLabel)
        view.addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1/3),
            imageView.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1/3),
            
            
            messageLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant:  12),
            messageLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
        
        

        self.backgroundView = view;
    }
    
    @objc func reloadFunc(){
        print("need to reload this page")
    }

    func restore() {
        self.backgroundView = nil
    }
}
