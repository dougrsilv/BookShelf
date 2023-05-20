//
//  DetailBookViewModel.swift
//  BookShelf
//
//  Created by Douglas  Rodrigues  on 09/04/23.
//

import Foundation

protocol DetailBookViewModelInput {
    func fetchListComments()
    func fetchListDetailBook()
}

protocol DetailBookViewModelOutput: AnyObject {
    func onListComments(list: [CommentsModel])
    func onListDetailBook(list: DetailBookModel?)
    func onListDetailBookError(error: serviceManagerError)
}

class DetailBookViewModel: DetailBookViewModelInput {
   
    private var datailBook: DetailBookModel? = nil
    private var service: serviceManager? = nil
    weak var delegate: DetailBookViewModelOutput?
    
    init(model: Books, service: serviceManager) {
        
        let model = DetailBookModel(author: model.author,
                                    category: model.category,
                                    id: model.id,
                                    photo: model.photo,
                                    price:  formatNumberToDecimal(value: model.price),
                                    stock: model.stock,
                                    title: model.title)
        
        self.datailBook = model
        self.service = service
    }
    
    private func captureIdBookAndConverterInt() -> Int {
        guard let converver = Int(datailBook?.id ?? "") else { return 0 }
        return converver
    }
    
    func fetchListDetailBook() {
        delegate?.onListDetailBook(list: datailBook)
    }
    
    func fetchListComments() {
        service?.get(path:  "/\(captureIdBookAndConverterInt())/Comments", type: [CommentsModel].self) { [weak self] service in
            DispatchQueue.main.async {
                guard let self = self else { return }
                switch service {
                case let .failure(erro):
                    self.delegate?.onListDetailBookError(error: erro)
                case let .success(success):
                    self.delegate?.onListComments(list: success)
                }
            }
        }
    }
    
    private func convertValueInttoString(value: Int) -> String {
        let value = String(value)
        return value
    }
    
    private func formatNumberToDecimal(value: String) -> String {
        let converter = (Double(value) ?? 0) / Double(100)
        let numberFormatter = NumberFormatter()
        numberFormatter.locale = Locale(identifier: "pt_BR")
        numberFormatter.minimumFractionDigits = 2
        numberFormatter.numberStyle = .decimal
        return numberFormatter.string(from: NSNumber(value: converter)) ?? "Valor indefinido"
    }
}
