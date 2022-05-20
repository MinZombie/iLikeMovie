//
//  RealmManager.swift
//  iLikeMovie
//
//  Created by 민선기 on 2022/05/06.
//

import Foundation
import RealmSwift

final class RealmManager {
    static let shared = RealmManager()
    
    private init() {}
    
    private let realm = try! Realm()
    
    func add(with item: MovieItemViewModel) {
        let movie = FavoriteMovie(
            title: item.title,
            link: item.link,
            image: item.image,
            director: item.director,
            actor: item.actor,
            userRating: item.userRating,
            isFavorite: true
        )
        try! self.realm.write {
            self.realm.add(movie)
        }
    }
    
    func get() -> [FavoriteMovie] {
        return Array(realm.objects(FavoriteMovie.self))
    }
    
    func remove(with item: MovieItemViewModel) {
        let moive = realm.objects(FavoriteMovie.self).where {
            $0.link == item.link
        }
        
        try! realm.write {
            realm.delete(moive)
        }
    }
}
