//
//  ListBookViewController.swift
//  BookShelf
//
//  Created by Douglas  Rodrigues  on 20/03/23.
//

import UIKit

class ListBookViewController: UIViewController {
    
    // MARK: - Properties
    
    private let listBookView = ListBookView()
    private let viewModel: ListBookViewModel
    
    init(viewModel: ListBookViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = listBookView
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        viewModel.fetchListBooks()
        listBookView.delegate = self
        viewModel.setupCoordinator()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
}

// MARK: - ListBookViewModelOutput

extension ListBookViewController: ListBookViewModelOutput {
    func onListBookLoaded(dic: [String : [Books]]) {
        listBookView.loadBoolShimmerView = false
        self.listBookView.category = dic
        self.listBookView.tableViewBooks.reloadData()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.listBookView.loadBoolShimmerView = true
            self.listBookView.category = dic
            self.listBookView.tableViewBooks.reloadData()
        }
    }
    
    func onFailure(name: BooksServiceError) {
        viewModel.openErrorViewController()
    }
}

// MARK: - ListBookViewDelegate

extension ListBookViewController: ListBookViewDelegate {
    func openScreenDetailBook(mode: Books) {
        viewModel.openDetailBookViewController(mode: mode)
    }
}

// MARK: - ErrorViewControllerDelegate

extension ListBookViewController: ErrorViewControllerDelegate {
    func loadingSerivceErrorViewController(bool: Bool) {
            super.viewWillAppear(bool)
            self.tabBarController?.tabBar.isHidden = false
            viewModel.delegate = self
            viewModel.fetchListBooks()
            listBookView.delegate = self
    }
}
