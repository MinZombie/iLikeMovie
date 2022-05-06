//
//  Movies.swift
//  iLikeMovie
//
//  Created by 민선기 on 2022/05/06.
//

import Foundation
import RealmSwift

struct Movies: Decodable {
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

class FavoriteMovie: Object {
    @Persisted var title: String
    @Persisted var link: String
    @Persisted var image: String
    @Persisted var director: String
    @Persisted var actor: String
    @Persisted var userRating: String
    @Persisted var isFavorite: Bool
    
    @Persisted(primaryKey: true) var _id: UUID
    
    convenience init(
        title: String,
        link: String,
        image: String,
        director: String,
        actor: String,
        userRating: String,
        isFavorite: Bool,
        id: UUID
    ) {
        self.init()
        self.title = title
        self.link = link
        self.image = image
        self.director = director
        self.actor = actor
        self.userRating = userRating
        self.isFavorite = isFavorite
        self._id = id
    }
}
