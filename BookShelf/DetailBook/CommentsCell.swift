//
//  CommentsCell.swift
//  BookShelf
//
//  Created by Douglas  Rodrigues  on 10/04/23.
//

import UIKit

class CommentsCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    private lazy var avaliacaoImageView: UIImageView = {
        let image = UIImageView()
        image.widthAnchor.constraint(equalToConstant: 120).isActive = true
        image.heightAnchor.constraint(equalToConstant: 24).isActive = true
        image.contentMode = .scaleAspectFit
        image.image = UIImage(named: "avaliacao-5")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var postTime: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = "10/10/20222 19:00:00"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var userPost: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = "teste@teste.com.br"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var commentsPost: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.background
        layer.cornerRadius = 12
        layer.masksToBounds = true
        clipsToBounds = true
        
        commentsPost.text = "Ea voluptatibus, praesentium tempore, voluptatibus distinctio, reprehenderit unde nam earum. Consequuntur ea voluptate, explicabo a a perspiciatis blanditiis a nulla, placeat deleniti nemo et amet, adipisci dicta eos, ad ea consectetur a."
        
        addSubview(avaliacaoImageView)
        addSubview(postTime)
        addSubview(userPost)
        addSubview(commentsPost)
        
        NSLayoutConstraint.activate([
            postTime.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            postTime.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            
            avaliacaoImageView.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            avaliacaoImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            
            userPost.topAnchor.constraint(equalTo: postTime.bottomAnchor, constant: 10),
            userPost.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            
            commentsPost.topAnchor.constraint(equalTo: userPost.bottomAnchor, constant: 10),
            commentsPost.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            commentsPost.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Fuctions
    
    func setupData(type: CommentsModel) {
        userPost.text = type.email
        avaliacaoImageView.image = UIImage(named: String(type.rate))
        commentsPost.text = type.body
        postTime.text = type.createdAt
    }
}
