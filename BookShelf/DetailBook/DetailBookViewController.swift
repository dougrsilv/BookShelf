//
//  DetailBookViewController.swift
//  BookShelf
//
//  Created by Douglas  Rodrigues  on 07/04/23.
//

import UIKit
 
class DetailBookViewController: UIViewController {
    
    // MARK: - Properties
    
    private let detailBookView = DetailBookView()
    private let viewModel: DetailBookViewModel
    
    init(viewModel: DetailBookViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = detailBookView
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        self.tabBarController?.tabBar.isHidden = true
        self.navigationItem.largeTitleDisplayMode = .never
        self.navigationController?.navigationBar.prefersLargeTitles = false
        
        viewModel.delegate = self
        viewModel.fetchListComments()
        viewModel.fetchListDetailBook()
    }
}

// MARK: - DetailBookViewModelOutput

extension DetailBookViewController: DetailBookViewModelOutput {
    func onListDetailBookError(error: CommentsServiceError) {
        let errorViewController = ErrorViewController()
        errorViewController.delegate = self
        
        let navBarOnModal: UINavigationController = UINavigationController(rootViewController: errorViewController)
        navBarOnModal.modalPresentationStyle = .overFullScreen
        navigationController?.present(navBarOnModal, animated: false)
    }
    
    func onListDetailBook(list: DetailBookModel?) {
        detailBookView.selectBooks = list
    }
    
    func onListComments(list: [CommentsModel]) {
        detailBookView.listCommentsBooks = list
        detailBookView.tableViewDetailBooks.reloadData()
    }
}

// MARK: - ErrorViewControllerDelegate

extension DetailBookViewController: ErrorViewControllerDelegate {
    func loadingSerivceErrorViewController(bool: Bool) {
        super.viewWillAppear(bool)
        self.tabBarController?.tabBar.isHidden = false
        viewModel.delegate = self
        viewModel.fetchListComments()
        viewModel.fetchListDetailBook()
    }
}

