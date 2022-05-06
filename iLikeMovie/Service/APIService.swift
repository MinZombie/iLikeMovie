//
//  APIService.swift
//  iLikeMovie
//
//  Created by 민선기 on 2022/05/06.
//

import Foundation

final class APIService {
    let baseUrl: String = "https://openapi.naver.com/v1/search/movie.json?display=10&"
    
    func search(query: String, page: Int, completion: @escaping (Result<Movies, Error>) -> Void) {
        let urlString = baseUrl + "query=\(query)" + "&" + "start=\((page * 10) + 1)"

        guard let encodedUrl = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
              let url = URL(string: encodedUrl) else {
            fatalError("fatalError - invalid url")
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue(APIKey.client_id, forHTTPHeaderField: "X-Naver-Client-Id")
        request.addValue(APIKey.client_secret, forHTTPHeaderField: "X-Naver-Client-Secret")
        request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else { return }
            
            do {
                let result = try JSONDecoder().decode(Movies.self, from: data)
                completion(.success(result))
            } catch {
                completion(.failure(error))
            }
        }
        .resume()
    }
}
