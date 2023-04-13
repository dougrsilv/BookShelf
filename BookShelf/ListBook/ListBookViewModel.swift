//
//  ListBookViewModel.swift
//  BookShelf
//
//  Created by Douglas  Rodrigues  on 20/03/23.
//

import Foundation

protocol ListBookViewModelInput {
    func fetchListBooks()
}

protocol ListBookViewModelOutput: AnyObject {
    func onFailure(name: BooksServiceError)
    func onListBookLoaded(dic: [String : [Books]])
}

class ListBookViewModel: ListBookViewModelInput {
    
    private let service: BooksServiceProtocol
    private var dictionary: [String: [Books]] = [:]
    weak var delegate: ListBookViewModelOutput?
    
    init(service: BooksServiceProtocol) {
        self.service = service
    }
    
    func fetchListBooks() {
        service.searchService { [weak self] service in
            DispatchQueue.main.async {
                guard let self = self else { return }
                switch service {
                case let .failure(erro):
                    self.delegate?.onFailure(name: erro)
                case let .success(success):
                    let terror = success.filter({ $0.category == "Terror" })
                    let comedia = success.filter({ $0.category == "Comédia" })
                    self.dictionary["Terror"] = terror
                    self.dictionary["Comédia"] = comedia
                    self.delegate?.onListBookLoaded(dic: self.dictionary)
                }
            }
        }
    }
}
