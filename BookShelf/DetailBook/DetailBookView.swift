//
//  DetailBookView.swift
//  BookShelf
//
//  Created by Douglas  Rodrigues  on 07/04/23.
//

import UIKit

class DetailBookView: UIView {
    
    // MARK: - Properties
    
    private let headerCell = "headerCell"
    private let describeCell = "describeCell"
    private let commentsCell = "commentsCell"
    var selectBooks: DetailBookModel?
    var listCommentsBooks: [CommentsModel] = []
    
    lazy var tableViewDetailBooks: UITableView = {
        let table = UITableView()
        table.delegate = self
        table.dataSource = self
        table.register(HeaderBuyDetailBookCell.self, forCellReuseIdentifier: headerCell)
        table.register(DescriptionDetailBookCell.self, forCellReuseIdentifier: describeCell)
        table.register(CommentsDetailBookCell.self, forCellReuseIdentifier: commentsCell)
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .darkGray
        addSubview(tableViewDetailBooks)
        
        NSLayoutConstraint.activate([
            tableViewDetailBooks.topAnchor.constraint(equalTo: topAnchor),
            tableViewDetailBooks.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableViewDetailBooks.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableViewDetailBooks.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - TableView

extension DetailBookView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.item == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: headerCell, for: indexPath) as! HeaderBuyDetailBookCell
            
            if let selectBooks = selectBooks {
                cell.setupData(books: selectBooks)
            }
            cell.minHeight = 220
            
            return cell
        }
        
        if indexPath.item == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: describeCell, for: indexPath) as! DescriptionDetailBookCell
            
            if let selectBooks = selectBooks {
                cell.setupData(books: selectBooks)
            }
            
            return cell
        }
        
        if indexPath.item == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: commentsCell, for: indexPath) as! CommentsDetailBookCell
            cell.listComments = listCommentsBooks
            cell.collectionView.reloadData()
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch indexPath.item {
        case 0:
            return UITableView.automaticDimension
        case 1:
            return CGFloat(130)
        case 2:
            return CGFloat(300)
        default:
            break
        }
        
        return CGFloat(0)
    }
}
