//
//  ListBookCell.swift
//  BookShelf
//
//  Created by Douglas  Rodrigues  on 20/03/23.
//

import UIKit

class ListBookCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    private lazy var titleListBook: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = "Harry Potter"
        label.numberOfLines = 2
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var imageListBook: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .purple
        image.layer.borderColor = UIColor(white: 0.5, alpha: 0.5).cgColor
        image.layer.cornerRadius = 12
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(imageListBook)
        addSubview(titleListBook)
        
        NSLayoutConstraint.activate([
            imageListBook.topAnchor.constraint(equalTo: topAnchor),
            imageListBook.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageListBook.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageListBook.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            titleListBook.topAnchor.constraint(equalTo: imageListBook.bottomAnchor, constant: 5),
            titleListBook.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleListBook.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Fuctions
    
    func setupData(setup: Books?) {
        guard let setup = setup else { return }
        titleListBook.text = setup.title
        
        let urlRequest = URLRequest(url: URL(string: setup.photo)!)
        
        URLSession.shared.dataTask(with: urlRequest) { data, result, error in
            let image = UIImage(data: data ?? Data())
            DispatchQueue.main.async {
                self.imageListBook.image = image
            }
        }.resume()
    }
}
