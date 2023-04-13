//
//  Books.swift
//  BookShelf
//
//  Created by Douglas  Rodrigues  on 20/03/23.
//

import Foundation

struct Books: Decodable {
    let author: String
    let category: String
    let id: Int
    let isHighlight: Bool
    let photo: String
    let price: Int
    let stock: Int
    let title: String
}
