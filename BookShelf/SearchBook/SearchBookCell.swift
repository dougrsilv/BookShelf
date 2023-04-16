//
//  SearchBookCell.swift
//  BookShelf
//
//  Created by Douglas  Rodrigues  on 16/04/23.
//

import UIKit

class SearchBookCell: UITableViewCell {
    
    // MARK: - Properties
    
    private lazy var imageSearchBook: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .purple
        image.layer.borderColor = UIColor(white: 0.5, alpha: 0.5).cgColor
        image.layer.cornerRadius = 12
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var titleSearchBook: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.text = "Drama"
        label.numberOfLines = 5
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Function
    
    func layout() {
        addSubview(imageSearchBook)
        addSubview(titleSearchBook)
        
        NSLayoutConstraint.activate([
            imageSearchBook.topAnchor.constraint(equalTo:  topAnchor, constant: 10),
            imageSearchBook.leadingAnchor.constraint(equalTo:  leadingAnchor, constant: 10),
            imageSearchBook.widthAnchor.constraint(equalToConstant: 150),
            imageSearchBook.heightAnchor.constraint(equalToConstant: 200),
            
            titleSearchBook.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            titleSearchBook.leadingAnchor.constraint(equalTo: imageSearchBook.trailingAnchor, constant: 30),
            titleSearchBook.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
        
        ])
    }
    
    func setupData(setup: Books) {
        
        let urlRequest = URLRequest(url: URL(string: setup.photo)!)
        
        URLSession.shared.dataTask(with: urlRequest) { data, result, error in
            let image = UIImage(data: data ?? Data())
            DispatchQueue.main.async {
                self.imageSearchBook.image = image
            }
        }.resume()
        
        titleSearchBook.text = setup.title
    }
}
