//
//  BooksService.swift
//  BookShelf
//
//  Created by Douglas  Rodrigues  on 20/03/23.
//

import Foundation

enum BooksServiceError: Error {
    case decodedError
    case newtwork(Error?)
}

protocol BooksServiceProtocol {
    func searchService(completion: @escaping (Result<[Books], BooksServiceError>) -> ())
}

class BooksService: BooksServiceProtocol {
    
    func searchService(completion: @escaping (Result<[Books], BooksServiceError>) -> ()) {
        
        guard let url = URL(string: "https://mockend.com/policante/rest-api/books") else { return }
        
        URLSession.shared.dataTask(with: url) { data, res, err in
            if let err = err {
                completion(.failure(.newtwork(err)))
            }
            
            do {
                guard let data = data else { return }
                let service = try JSONDecoder().decode([Books].self, from: data)
                completion(.success(service))
            } catch let err {
                completion(.failure(.decodedError))
                print(err)
                return
            }
        }.resume()
    }
}

