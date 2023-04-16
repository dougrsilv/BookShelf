//
//  ListBookCellShimmer.swift
//  BookShelf
//
//  Created by Douglas  Rodrigues  on 13/04/23.
//

import UIKit

class ListBookCellShimmer: UICollectionViewCell {
    
    // MARK: - Properties
    
    private lazy var titleListBookShimmer: UILabel = {
        let label = UILabel()
        label.text = "Harry Potter"
        return label
    }()
    private lazy var imageListBookShimmer = UIImageView()
    private lazy var titleListBookLayerShimmer = CAGradientLayer()
    private lazy var imageListBookLayerShimmer = CAGradientLayer()
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        layout()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        titleListBookLayerShimmer.frame = titleListBookShimmer.bounds
        titleListBookLayerShimmer.cornerRadius = titleListBookShimmer.bounds.height / 10
        
        imageListBookLayerShimmer.frame = imageListBookShimmer.bounds
        imageListBookLayerShimmer.cornerRadius = imageListBookShimmer.bounds.height / 12
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Functions
    
    func setup() {
        
        titleListBookShimmer.translatesAutoresizingMaskIntoConstraints = false
        imageListBookShimmer.translatesAutoresizingMaskIntoConstraints = false
        
        titleListBookLayerShimmer.startPoint = CGPoint(x: 0, y: 0.5)
        titleListBookLayerShimmer.endPoint = CGPoint(x: 1, y: 0.5)
        titleListBookShimmer.layer.addSublayer(titleListBookLayerShimmer)

        imageListBookLayerShimmer.startPoint = CGPoint(x: 0, y: 0.5)
        imageListBookLayerShimmer.endPoint = CGPoint(x: 1, y: 0.5)
        imageListBookShimmer.layer.addSublayer(imageListBookLayerShimmer)

        let titleGroup = SkeletonLoadable.shared.makeAnimationGroup()
        titleGroup.beginTime = 0.0
        titleListBookLayerShimmer.add(titleGroup, forKey: "backgroundColor")
        
        let yearGroup = SkeletonLoadable.shared.makeAnimationGroup(previousGroup: titleGroup)
        imageListBookLayerShimmer.add(yearGroup, forKey: "backgroundColor")
    }
    
    func layout() {
        addSubview(imageListBookShimmer)
        addSubview(titleListBookShimmer)
        
        NSLayoutConstraint.activate([
            imageListBookShimmer.topAnchor.constraint(equalTo: topAnchor),
            imageListBookShimmer.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageListBookShimmer.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageListBookShimmer.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            titleListBookShimmer.topAnchor.constraint(equalTo: imageListBookShimmer.bottomAnchor, constant: 5),
            titleListBookShimmer.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleListBookShimmer.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }
}
