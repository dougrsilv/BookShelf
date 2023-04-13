//
//  CommentsDetailBookCell.swift
//  BookShelf
//
//  Created by Douglas  Rodrigues  on 10/04/23.
//

import UIKit

class CommentsDetailBookCell: UITableViewCell {
    
    // MARK: - Properties
    
    private let cell = "cell"
    var listComments: [CommentsModel] = []
    
    private lazy var titleDetailBook: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.text = "Comentários"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var collectionView: UICollectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout.init())
        cv.delegate = self
        cv.dataSource = self
        cv.register(CommentsCell.self, forCellWithReuseIdentifier: cell)
        let cf: UICollectionViewFlowLayout = UICollectionViewFlowLayout.init()
        cf.scrollDirection = .horizontal
        cv.setCollectionViewLayout(cf, animated: false)
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()
    
    // MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(titleDetailBook)
        contentView.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            titleDetailBook.topAnchor.constraint(equalTo: topAnchor),
            titleDetailBook.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            
            collectionView.topAnchor.constraint(equalTo: titleDetailBook.bottomAnchor, constant: 20),
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - UICollectionView

extension CommentsDetailBookCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listComments.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cell, for: indexPath) as! CommentsCell
        cell.setupData(type: listComments[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: collectionView.bounds.width - 40, height: collectionView.bounds.height)
    }
}
