//
//  CommentsService.swift
//  BookShelf
//
//  Created by Douglas  Rodrigues  on 10/04/23.
//

import Foundation

enum CommentsServiceError: Error {
    case decodedError
    case network(Error?)
}

protocol CommentsServiceProtocol {
    func searchService(bookId: Int, completion: @escaping (Result<[CommentsModel], CommentsServiceError>) -> ())
}

class CommentsService: CommentsServiceProtocol {
    
    func searchService(bookId: Int, completion: @escaping (Result<[CommentsModel], CommentsServiceError>) -> ()) {
        
        guard let url = URL(string: "https://64382d9bf3a0c40814acc039.mockapi.io/devpoli/books/\(bookId)/Comments") else { return }
        
        URLSession.shared.dataTask(with: url) { data, res, err in
            if let err = err {
                completion(.failure(.network(err)))
            }
            
            do {
                guard let data = data else { return }
                let service = try JSONDecoder().decode([CommentsModel].self, from: data)
                completion(.success(service))
            } catch let err {
                completion(.failure(.decodedError))
                print(err)
                return
            }
        }.resume()
    }
}
