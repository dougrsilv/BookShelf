//
//  ListBookTableCell.swift
//  BookShelf
//
//  Created by Douglas  Rodrigues  on 20/03/23.
//

import UIKit

protocol ListBookTableCellDelegate: AnyObject {
    func clickOpenIdBook(mode: Books)
}
 
class ListBookTableCell: UITableViewCell {
    
    // MARK: - Properties
    
    private let cell = "cellCollection"
    private let cellShimmer = "cellShimmer"
    var categoryList: [Books] = []
    weak var delegate: ListBookTableCellDelegate?
    private var loadedShimmerView = false
    private lazy var titleLayer = CAGradientLayer()
    
    private lazy var titleListBook: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 24)
        label.text = "Drama"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var collectionView: UICollectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout.init())
        cv.delegate = self
        cv.dataSource = self
        cv.register(ListBookCell.self, forCellWithReuseIdentifier: cell)
        cv.register(ListBookCellShimmer.self, forCellWithReuseIdentifier: cellShimmer)
        let cf: UICollectionViewFlowLayout = UICollectionViewFlowLayout.init()
        cf.scrollDirection = .horizontal
        cv.setCollectionViewLayout(cf, animated: false)
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()
    
    // MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        titleLayer.frame = titleListBook.bounds
        titleLayer.cornerRadius = titleListBook.bounds.height / 10
    }
    
    // MARK: - Fuctions
    
    func setup() {
        titleLayer.startPoint = CGPoint(x: 0, y: 0.5)
        titleLayer.endPoint = CGPoint(x: 1, y: 0.5)
        titleListBook.layer.addSublayer(titleLayer)
        
        let titleGroup = SkeletonLoadable.shared.makeAnimationGroup()
        titleGroup.beginTime = 0.0
        titleLayer.add(titleGroup, forKey: "backgroundColor")
    }
    
    func layout() {
        contentView.addSubview(titleListBook)
        contentView.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            titleListBook.topAnchor.constraint(equalTo:  contentView.topAnchor, constant: 5),
            titleListBook.leadingAnchor.constraint(equalTo:  contentView.leadingAnchor),
            
            collectionView.topAnchor.constraint(equalTo: titleListBook.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
    
    func loadedShimmerViewListBook(value: Bool) {
        loadedShimmerView = value
        collectionView.reloadData()
    }
}

// MARK: - UICollectionViewDelegate

extension ListBookTableCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
       
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoryList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if loadedShimmerView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cell, for: indexPath) as! ListBookCell
            cell.setupData(setup: categoryList[indexPath.row])
            titleListBook.text = categoryList[indexPath.row].category
            titleLayer.isHidden = true
            return cell
        } else {
            let cellShimmer = collectionView.dequeueReusableCell(withReuseIdentifier: cellShimmer, for: indexPath) as! ListBookCellShimmer
            return cellShimmer
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.clickOpenIdBook(mode: categoryList[indexPath.row])
    }
}
