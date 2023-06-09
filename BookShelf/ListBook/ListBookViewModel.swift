//
//  ListBookViewModel.swift
//  BookShelf
//
//  Created by Douglas  Rodrigues  on 20/03/23.
//

import UIKit

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
    private var listArrayTitle = [String]()
    weak var delegate: ListBookViewModelOutput?
    
    init(service: BooksServiceProtocol) {
        self.service = service
    }
    
    private func removeDuplicates(array: [String]) -> [String] {
        var encountered = Set<String>()
        var result: [String] = []
        for value in array {
            if encountered.contains(value) {
            }
            else {
                encountered.insert(value)
                result.append(value)
            }
        }
        return result
    }
    
    func fetchListBooks() {
        service.searchService { [weak self] service in
            DispatchQueue.main.async {
                guard let self = self else { return }
                switch service {
                case let .failure(erro):
                    self.delegate?.onFailure(name: erro)
                case let .success(success):
                    
                    for list in success {
                        self.listArrayTitle.append(list.category)
                    }
                    
                    for newList in self.removeDuplicates(array: self.listArrayTitle) {
                        let info = success.filter({ $0.category == newList })
                        self.dictionary[newList] = info
                    }
                    self.delegate?.onListBookLoaded(dic: self.dictionary)
                }
            }
        }
    }
}
