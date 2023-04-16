//
//  CommentsModel.swift
//  BookShelf
//
//  Created by Douglas  Rodrigues  on 10/04/23.
//

import Foundation

struct CommentsModel: Decodable {    
    let email: String
    let body: String
    let rate: Int
    let createdAt: Int
    let id: String
    let bookId: String
}
