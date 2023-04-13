//
//  HeaderBuyDetailBookCell.swift
//  BookShelf
//
//  Created by Douglas  Rodrigues  on 08/04/23.
//

import UIKit

class HeaderBuyDetailBookCell: UITableViewCell {
    
    // MARK: - Properties
    
    private lazy var imageDetailBook: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .purple
        image.layer.borderColor = UIColor(white: 0.5, alpha: 0.5).cgColor
        image.layer.cornerRadius = 12
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var titleDetailBook: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.text = "Drama"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var amountTitleDetailBook: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.text = "Quantidade:"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var amountDetailBook: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var priceTitleDetailBook: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.text = "Preço:"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var priceDetailBook: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = "70.00"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var stackDetailBook: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [amountTitleDetailBook,
                                                   amountDetailBook,
                                                   priceTitleDetailBook,
                                                   priceDetailBook])
        stack.axis = .vertical
        stack.spacing = 2
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    // MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(imageDetailBook)
        addSubview(titleDetailBook)
        addSubview(stackDetailBook)
        
        NSLayoutConstraint.activate([
            imageDetailBook.topAnchor.constraint(equalTo:  topAnchor, constant: 10),
            imageDetailBook.leadingAnchor.constraint(equalTo:  leadingAnchor, constant: 10),
            imageDetailBook.widthAnchor.constraint(equalToConstant: 150),
            imageDetailBook.heightAnchor.constraint(equalToConstant: 200),
            
            titleDetailBook.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            titleDetailBook.leadingAnchor.constraint(equalTo: imageDetailBook.trailingAnchor, constant: 30),
            
            stackDetailBook.topAnchor.constraint(equalTo: titleDetailBook.bottomAnchor, constant: 20),
            stackDetailBook.leadingAnchor.constraint(equalTo: imageDetailBook.trailingAnchor, constant: 30)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupData(books: DetailBookModel) {
        
        let urlRequest = URLRequest(url: URL(string: books.photo)!)
        
        URLSession.shared.dataTask(with: urlRequest) { data, result, error in
            let image = UIImage(data: data ?? Data())
            DispatchQueue.main.async {
                self.imageDetailBook.image = image
            }
        }.resume()
        
        titleDetailBook.text = books.title
        amountDetailBook.text = books.stock
        priceDetailBook.text = "R$ \(books.price)"
    }
}
