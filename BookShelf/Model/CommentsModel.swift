//
//  CommentsModel.swift
//  BookShelf
//
//  Created by Douglas  Rodrigues  on 10/04/23.
//

import Foundation

struct CommentsModel: Decodable {
    let body: String
    let bookId: Int
    let createdAt: String
    let email: String
    let id: Int
    let rate: Int
}
