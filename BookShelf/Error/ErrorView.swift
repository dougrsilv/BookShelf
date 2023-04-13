//
//  ErrorView.swift
//  BookShelf
//
//  Created by Douglas  Rodrigues  on 11/04/23.
//

import UIKit

protocol ErrorViewDelegate: AnyObject {
    func clickButtonUpdateErrorView()
}

class ErrorView: UIView {
    
    // MARK: - Properties
    
    weak var delegate: ErrorViewDelegate?
    
    private lazy var imageError: UIImageView = {
        let image = UIImageView()
        image.layer.borderColor = UIColor(white: 0.5, alpha: 0.5).cgColor
        image.image = UIImage(named: "fechar")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var titleError: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 24)
        label.text = "Ops alguma coisa deu errado..."
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var loadingErrorButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Tentar Novamente", for: .normal)
        button.layer.cornerRadius = 3
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.layer.borderWidth = 0.5
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(.black, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handlerErrorButtonTapped), for: .touchUpInside)
        return button
    }()
    
    // MARK: Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        
        addSubview(imageError)
        addSubview(titleError)
        addSubview(loadingErrorButton)
        
        NSLayoutConstraint.activate([
            imageError.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageError.centerYAnchor.constraint(equalTo: centerYAnchor),
            imageError.heightAnchor.constraint(equalToConstant: 100),
            imageError.widthAnchor.constraint(equalToConstant: 100),
            
            titleError.topAnchor.constraint(equalTo: imageError.bottomAnchor, constant: 10),
            titleError.centerXAnchor.constraint(equalTo: imageError.centerXAnchor),
            
            loadingErrorButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            loadingErrorButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -25),
            loadingErrorButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -20),
            loadingErrorButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Fuctions
    
    @objc func handlerErrorButtonTapped() {
        delegate?.clickButtonUpdateErrorView()
    }
    
}
