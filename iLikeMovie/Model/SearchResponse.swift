//
//  Movies.swift
//  iLikeMovie
//
//  Created by 민선기 on 2022/05/06.
//

import Foundation

struct SearchResponse: Decodable {
    let total: Int
    let display: Int
    let items: [Movie]
}

struct Movie: Decodable {
    let title: String
    let link: String
    let image: String
    let director: String
    let actor: String
    let userRating: String

}


