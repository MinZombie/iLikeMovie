//
//  MovieListViewModel.swift
//  iLikeMovie
//
//  Created by 민선기 on 2022/05/06.
//

import Foundation

protocol MovieListInput {
    func search(query: String)
}

protocol MovieListOutput {
    var movies: Observable<[MovieItemViewModel]> { get }
}

protocol MovieListViewModel: MovieListInput, MovieListOutput {}

final class DefaultMovieListViewModel: MovieListViewModel {
    // MARK: - Properties
    private let service: APIServiceProtocol
    private var page: Int = 0
    private var total: Int = 0
    
    // MARK: - Output
    var movies: Observable<[MovieItemViewModel]> = Observable([])
    
    init(service: APIServiceProtocol) {
        self.service = service
    }
}

extension DefaultMovieListViewModel {
    // MARK: - Input
    func search(query: String) {
        self.movies.value.removeAll()
        self.page = 0
        
        service.search(query: query, page: page) { result in
            switch result {
            case .success(let response):
                
                _ = response.items.map { self.movies.value.append(MovieItemViewModel.init(movie: $0)) }
                self.total = response.total
                
            case .failure(let error):
                
                print(error)
            }
        }
    }
}
