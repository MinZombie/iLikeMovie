//
//  MovieListViewModel.swift
//  iLikeMovie
//
//  Created by 민선기 on 2022/05/06.
//

import Foundation
import UIKit

protocol MovieListInput {
    func search(query: String)
    func addFavorite(with item: MovieItemViewModel)
    func removeFavorite(with item: MovieItemViewModel)
    func getFavoriteMovies()
    func prefetch()
}

protocol MovieListOutput {
    var movies: Observable<[MovieItemViewModel]> { get }
    var favoriteMovies: Observable<[MovieItemViewModel]> { get }
    var isLoading: Bool { get }
}

protocol MovieListViewModel: MovieListInput, MovieListOutput {}

final class DefaultMovieListViewModel: MovieListViewModel {
    // MARK: - Properties
    private let service: APIServiceProtocol
    private var page: Int = 0
    private var total: Int = 0
    private var query: String = ""
    
    // MARK: - Output
    var movies: Observable<[MovieItemViewModel]> = Observable([])
    var favoriteMovies: Observable<[MovieItemViewModel]> = Observable([])
    var isLoading: Bool = false
    
    init(service: APIServiceProtocol) {
        self.service = service
    }
}

extension DefaultMovieListViewModel {
    // MARK: - Input
    func search(query: String) {
        self.movies.value.removeAll()
        self.page = 0
        self.query = query
        
        service.search(query: query, page: page) { result in
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    self.getFavoriteMovies()
                    let linksOfFavoriteMovies = Set(self.favoriteMovies.value.map { $0.link })
                    let linksOfSearchedMovies = Set(response.items.map { $0.link })
                    let sameLinks: Set<String> = linksOfFavoriteMovies.intersection(linksOfSearchedMovies)

                    _ = response.items.map {
                        self.movies.value.append(
                            MovieItemViewModel.init(
                                movie: $0,
                                isFavorite: sameLinks.contains($0.link) ? true : false
                            )
                        )
                    }
                    self.total = response.total
                }
                
            case .failure(let error):
                
                print(error)
            }
        }
    }
    
    func getFavoriteMovies() {
        favoriteMovies.value.removeAll()
        let temp = RealmManager.shared.get()
        temp.forEach {
            favoriteMovies.value.append(
                .init(
                    movie: .init(
                        title: $0.title,
                        link: $0.link,
                        image: $0.image,
                        director: $0.director,
                        actor: $0.actor,
                        userRating: $0.userRating
                    ),
                    isFavorite: true
                )
            )
        }
    }
    
    func addFavorite(with item: MovieItemViewModel) {
        RealmManager.shared.add(with: item)
        favoriteMovies.value.append(
            .init(
                movie: .init(
                    title: item.title,
                    link: item.link,
                    image: item.image,
                    director: item.director,
                    actor: item.actor,
                    userRating: item.userRating
                ),
                isFavorite: true
            )
        )
        for i in 0..<movies.value.count {
            if movies.value[i].link == item.link {
                movies.value[i].isFavorite = true
            }
        }
    }
    
    func removeFavorite(with item: MovieItemViewModel) {
        RealmManager.shared.remove(with: item)
        let filtered = favoriteMovies.value.filter { $0.link != item.link }
        favoriteMovies.value = filtered
        
        for i in 0..<movies.value.count {
            if movies.value[i].link == item.link {
                movies.value[i].isFavorite = false
            }
        }
    }
    
    func prefetch() {
        guard (page * 10) < total else {
            return
        }
        
        self.page += 1
        self.isLoading = true
        
        service.search(query: query, page: page) { result in
            self.isLoading = false
            
            switch result {
            case .success(let response):
                
                let linksOfFavoriteMovies = Set(self.favoriteMovies.value.map { $0.link })
                let linksOfSearchedMovies = Set(response.items.map { $0.link })
                let sameLinks: Set<String> = linksOfFavoriteMovies.intersection(linksOfSearchedMovies)
                
                _ = response.items.map {
                    self.movies.value.append(
                        MovieItemViewModel.init(
                            movie: $0,
                            isFavorite: sameLinks.contains($0.link) ? true : false
                        )
                    )
                }
                
            case .failure(let error):
                
                print(error)
            }
        }
    }
}
