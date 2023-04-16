//
//  SearchBookViewModel.swift
//  BookShelf
//
//  Created by Douglas  Rodrigues  on 16/04/23.
//

import Foundation

protocol SearchBookViewModelInput {
    func fetchListBooks()
}

protocol SearchBookViewModelOutput: AnyObject {
    func onFailure(name: BooksServiceError)
    func onListBookLoaded(list: [Books])
}

class SearchBookViewModel: SearchBookViewModelInput {
   
    private let service: BooksServiceProtocol
    private var books: [Books] = []
    weak var delegate: SearchBookViewModelOutput?
    
    init(service: BooksServiceProtocol) {
        self.service = service
    }
    
    func fetchListBooks() {
        service.searchService { [weak self] service in
            DispatchQueue.main.async {
                guard let self = self else { return }
                switch service {
                case let .failure(erro):
                    print(erro)
                case let .success(success):
                    self.books.append(contentsOf: success)
                    self.delegate?.onListBookLoaded(list: self.books)
                }
            }
        }
    }
}
