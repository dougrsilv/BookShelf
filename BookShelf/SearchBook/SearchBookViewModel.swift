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
    func onFailure(name: serviceManagerError)
    func onListBookLoaded(list: [Books])
}

class SearchBookViewModel: SearchBookViewModelInput {
   
    private let service: ServiceManager
    private var books: [Books] = []
    weak var delegate: SearchBookViewModelOutput?
    
    init(service: ServiceManager) {
        self.service = service
    }
    
    func fetchListBooks() {
        service.get(path: "", type: [Books].self) { [weak self]  service in
            guard let self = self else { return }
            switch service {
            case let .failure(erro):
                self.delegate?.onFailure(name: erro)
            case let .success(success):
                self.books.append(contentsOf: success)
                self.delegate?.onListBookLoaded(list: self.books)
            }
        }
    }
}
