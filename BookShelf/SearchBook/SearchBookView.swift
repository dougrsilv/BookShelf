//
//  SearchBookView.swift
//  BookShelf
//
//  Created by Douglas  Rodrigues  on 16/04/23.
//

import UIKit

protocol SearchBookViewDelegate: AnyObject {
    func selectBooks(list: Books)
}

class SearchBookView: UIView {
    
    // MARK: - Properties
    
    private let cell = "cell"
    var listFilter = [Books]()
    var listBooks = [Books]()
    var decideToListBooks: Bool = false
    weak var delegate: SearchBookViewDelegate?
    
    private lazy var titleError: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 24)
        label.text = "Resultado não encontrado..."
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
   
    lazy var tableViewSearchBooks: UITableView = {
        let table = UITableView()
        table.delegate = self
        table.dataSource = self
        table.register(SearchBookCell.self, forCellReuseIdentifier: cell)
        table.rowHeight = 230
        table.separatorStyle = .none
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    // MARK: Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Functions
    
    private func setup() {
        addSubview(tableViewSearchBooks)
        addSubview(titleError)
        
        NSLayoutConstraint.activate([
            tableViewSearchBooks.topAnchor.constraint(equalTo: topAnchor),
            tableViewSearchBooks.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            tableViewSearchBooks.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            tableViewSearchBooks.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            titleError.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleError.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }
    
    func hideTableOrMessage(count: Int) {
        if count == 0 {
            tableViewSearchBooks.isHidden = true
            titleError.isHidden = false
        } else {
            tableViewSearchBooks.isHidden = false
            titleError.isHidden = true
        }
    }
    
    func hideTitleOrHideTableViewBookSearch(title: Bool, tableView: Bool) {
        titleError.isHidden = title
        tableViewSearchBooks.isHidden = tableView
    }
}

// MARK: - TableViewDelegate

extension SearchBookView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return decideToListBooks ? listFilter.count : listBooks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cell, for: indexPath) as! SearchBookCell
        if decideToListBooks {
            cell.setupData(setup: listFilter[indexPath.row])
        } else {
            cell.setupData(setup: listBooks[indexPath.row])
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if decideToListBooks {
            delegate?.selectBooks(list: listFilter[indexPath.row])
        } else {
            delegate?.selectBooks(list: listBooks[indexPath.row])
        }
    }
}
