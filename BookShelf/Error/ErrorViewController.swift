//
//  ErrorViewController.swift
//  BookShelf
//
//  Created by Douglas  Rodrigues  on 11/04/23.
//

import UIKit

protocol ErrorViewControllerDelegate: AnyObject {
    func loadingSerivceErrorViewController(bool: Bool)
}

class ErrorViewController: UIViewController {
    
    // MARK: - Properties
    
    let errorView = ErrorView()
    weak var delegate: ErrorViewControllerDelegate?
    
    override func loadView() {
        view = errorView
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.isHidden = true
        errorView.delegate = self
    }
}

// MARK: - ErrorViewDelegate

extension ErrorViewController: ErrorViewDelegate {
    func clickButtonUpdateErrorView() {
        delegate?.loadingSerivceErrorViewController(bool: true)
        navigationController?.dismiss(animated: true)
    }
}
