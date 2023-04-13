//
//  DetailBookViewModel.swift
//  BookShelf
//
//  Created by Douglas  Rodrigues  on 09/04/23.
//

import Foundation

protocol DetailBookViewModelProtocol {
    func searchService(completion: @escaping (Result<[CommentsModel], CommentsServiceError>) -> ())
}

class DetailBookViewModel: DetailBookViewModelProtocol {
   
    private var datailBook: DetailBookModel? = nil
    private var service: CommentsServiceProtocol? = nil
    private var listComments = [CommentsModel]()
    
    init(model: Books, service: CommentsServiceProtocol) {
        
        let model = DetailBookModel(author: model.author,
                                    category: model.category,
                                    id: model.id,
                                    photo: model.photo,
                                    price: formatNumberToDecimal(value: model.price),
                                    stock: convertValueInttoString(value: model.stock),
                                    title: model.title)
        
        self.datailBook = model
        self.service = service
    }
    
    
    
    func setupData() -> DetailBookModel? {
        return datailBook
    }
    
    func searchService(completion: @escaping (Result<[CommentsModel], CommentsServiceError>) -> ()) {
        service?.searchService(completion: { [weak self] service in
            DispatchQueue.main.async {
                guard let self = self else { return }
                switch service {
                case let .failure(erro):
                    completion(.failure(erro))
                case let .success(success):
                    let filterId = success.filter({$0.bookId == self.datailBook?.id})
                    self.listComments.append(contentsOf: filterId)
                    completion(.success(self.listComments))
                }
            }
        })
    }
    
    private func convertValueInttoString(value: Int) -> String {
        let value = String(value)
        return value
    }
    
    private func formatNumberToDecimal(value: Int) -> String {
        let converter = Double(value) / Double(100)
        let numberFormatter = NumberFormatter()
        numberFormatter.locale = Locale(identifier: "pt_BR")
        numberFormatter.minimumFractionDigits = 2
        numberFormatter.numberStyle = .decimal
        return numberFormatter.string(from: NSNumber(value: converter)) ?? "Valor indefinido"
    }
}
