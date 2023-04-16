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
        
        detailBookView.selectBooks = viewModel.setupData()
        
        viewModel.searchService(bookId: viewModel.captureIdBookAndConverterInt()) { [weak self] service in
            guard let self = self else { return }
            switch service {
            case let .success(sucess):
                self.detailBookView.listCommentsBooks = sucess
                self.detailBookView.tableViewDetailBooks.reloadData()
            case let .failure(erro):
                print(erro)
            }
        }
    }
}
