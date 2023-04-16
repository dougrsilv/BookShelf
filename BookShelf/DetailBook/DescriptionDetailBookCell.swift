//
//  DescriptionDetailBookCell.swift
//  BookShelf
//
//  Created by Douglas  Rodrigues  on 08/04/23.
//

import UIKit

class DescriptionDetailBookCell: UITableViewCell {
    
    // MARK: - Properties
    
    private lazy var titleDetailBook: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.text = "Carateristicas"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var authorTitleDetailBook: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.text = "Autor:"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var authorDetailBook: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = "Teste"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var categoryTitleDetailBook: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.text = "Categoria:"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var categoryDetailBook: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = "Terror"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var stackViewCategory: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [authorTitleDetailBook,
                                                   authorDetailBook,
                                                   categoryTitleDetailBook,
                                                   categoryDetailBook])
        stack.axis = .vertical
        stack.spacing = 2
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    // MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(titleDetailBook)
        addSubview(stackViewCategory)
        
        NSLayoutConstraint.activate([
            titleDetailBook.topAnchor.constraint(equalTo: topAnchor),
            titleDetailBook.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            
            stackViewCategory.topAnchor.constraint(equalTo: titleDetailBook.bottomAnchor, constant: 10),
            stackViewCategory.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Functions
    
    func setupData(books: DetailBookModel) {
        authorDetailBook.text = books.author
        categoryDetailBook.text = books.category
    }
    
}
