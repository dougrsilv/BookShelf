//
//  SearchBookViewController.swift
//  BookShelf
//
//  Created by Douglas  Rodrigues  on 20/03/23.
//

import UIKit

class SearchBookViewController: UIViewController {
    
    // MARK: - Properties
    
    private let searchBookView = SearchBookView()
    private let searchController = UISearchController(searchResultsController: nil)
    private let viewModel: SearchBookViewModel
    private var filterBooks = [Books]()
    private var filterResults = [Books]()
    
    private var inSearchMode: Bool {
        return searchController.isActive && !searchController.searchBar.text!.isEmpty
    }
    
    override func loadView() {
        view = searchBookView
    }
    
    init(viewModel: SearchBookViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurarSearchBar()
        viewModel.delegate = self
        viewModel.fetchListBooks()
        searchBookView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    // MARK: - Functions
    
    private func configurarSearchBar() {
        navigationItem.searchController = self.searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        self.searchController.obscuresBackgroundDuringPresentation = false
        self.searchController.searchBar.placeholder = "Pesquisar livros"
        self.searchController.searchBar.delegate = self
    }
}

// MARK: - SearchBookViewModelOutput

extension SearchBookViewController: SearchBookViewModelOutput {
    func onFailure(name: BooksServiceError) {
        print(name)
    }
    
    func onListBookLoaded(list: [Books]) {
        filterBooks = list
        searchBookView.listBooks = list
        searchBookView.hideTitleOrHideTableViewBookSearch(title: true, tableView: false)
        searchBookView.tableViewSearchBooks.reloadData()
    }
}

// MARK: - UISearchBarDelegate

extension SearchBookViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filterResults = filterBooks.filter({$0.title.contains(searchText)})
        searchBookView.hideTableOrMessage(count: filterResults.count)
        searchBookView.listFilter = filterResults
        searchBookView.decideToListBooks = true
        searchBookView.tableViewSearchBooks.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBookView.decideToListBooks = !searchBar.showsCancelButton
        searchBookView.hideTitleOrHideTableViewBookSearch(title: true, tableView: false)
        searchBookView.tableViewSearchBooks.reloadData()
    }
}

// MARK: - SearchBookViewDelegate

extension SearchBookViewController: SearchBookViewDelegate {
    func selectBooks(list: Books) {
        let commentsService = CommentsService()
        let detailModel = DetailBookViewModel(model: list, service: commentsService)
        let detailBookViewController = DetailBookViewController(viewModel: detailModel)
        self.navigationController?.pushViewController(detailBookViewController, animated: true)
    }
}


