//
//  MovieItemViewModel.swift
//  iLikeMovie
//
//  Created by 민선기 on 2022/05/06.
//

import Foundation

struct MovieItemViewModel: Equatable {
    let title: String
    let link: String
    let image: String
    let director: String
    let actor: String
    let userRating: String
    var isFavorite: Bool
    let id: UUID
    
    init(
        movie: Movie,
        isFavorite: Bool = false,
        id: UUID = UUID()
    ) {
        self.title = movie.title.replacingOccurrences(of: "</b>", with: "").replacingOccurrences(of: "<b>", with: "")
        self.link = movie.link
        self.image = movie.image
        self.director = "감독: \(movie.director.split(separator: "|").joined(separator: ", "))"
        self.actor = "출연: \(movie.actor.split(separator: "|").joined(separator: ", "))"
        self.userRating = "평점: \(movie.userRating)"
        self.isFavorite = isFavorite
        self.id = id
    }

}
