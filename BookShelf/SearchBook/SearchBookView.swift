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
    weak var delegate: SearchBookViewDelegate?
   
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
    
    func setup() {
        addSubview(tableViewSearchBooks)
        
        NSLayoutConstraint.activate([
            tableViewSearchBooks.topAnchor.constraint(equalTo: topAnchor),
            tableViewSearchBooks.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            tableViewSearchBooks.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            tableViewSearchBooks.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}

// MARK: - TableViewDelegate

extension SearchBookView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listFilter.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cell, for: indexPath) as! SearchBookCell
        cell.setupData(setup: listFilter[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.selectBooks(list: listFilter[indexPath.row])
    }
}


