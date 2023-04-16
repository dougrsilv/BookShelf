//
//  ListBookView.swift
//  BookShelf
//
//  Created by Douglas  Rodrigues  on 20/03/23.
//

import UIKit

protocol ListBookViewDelegate: AnyObject {
    func openScreenDetailBook(mode: Books)
}

class ListBookView: UIView {
   
    // MARK: - Properties
    
    private let cell = "Cell"
    var category: [String : [Books]] = [:]
    weak var delegate: ListBookViewDelegate?
    var loadBoolShimmerView = false
    
    lazy var tableViewBooks: UITableView = {
        let table = UITableView()
        table.delegate = self
        table.dataSource = self
        table.register(ListBookTableCell.self, forCellReuseIdentifier: cell)
        table.rowHeight = 310
        table.allowsSelection = false
        table.separatorStyle = .none
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        addSubview(tableViewBooks)
        
        NSLayoutConstraint.activate([
            tableViewBooks.topAnchor.constraint(equalTo: topAnchor),
            tableViewBooks.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            tableViewBooks.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            tableViewBooks.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - TableView

extension ListBookView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return category.keys.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cell, for: indexPath) as! ListBookTableCell
        cell.selectionStyle = .none
        let key = Array(category.keys)[indexPath.row]
        cell.categoryList = category[key] ?? []
        cell.delegate = self
        cell.loadedShimmerViewListBook(value: loadBoolShimmerView)
        return cell
    }
}

extension ListBookView: ListBookTableCellDelegate {
    func clickOpenIdBook(mode: Books) {
        delegate?.openScreenDetailBook(mode: mode)
    }
}
