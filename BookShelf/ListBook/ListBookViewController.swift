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
    
    func onFailure(name: serviceManagerError) {
        let errorViewController = ErrorViewController()
        errorViewController.delegate = self
        
        let navBarOnModal: UINavigationController = UINavigationController(rootViewController: errorViewController)
        navBarOnModal.modalPresentationStyle = .overFullScreen
        navigationController?.present(navBarOnModal, animated: false)
    }
}

// MARK: - ListBookViewDelegate

extension ListBookViewController: ListBookViewDelegate {
    func openScreenDetailBook(mode: Books) {
        guard let serviceManager = try? ServiceManager(base: "https://64382d9bf3a0c40814acc039.mockapi.io/devpoli/books") else { return }
        let detailModel = DetailBookViewModel(model: mode, service: serviceManager)
        let detailBookViewController = DetailBookViewController(viewModel: detailModel)
        self.navigationController?.pushViewController(detailBookViewController, animated: true)
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
