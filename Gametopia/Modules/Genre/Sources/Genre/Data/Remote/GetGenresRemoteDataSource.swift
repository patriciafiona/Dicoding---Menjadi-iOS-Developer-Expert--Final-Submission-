//
//  File.swift
//  
//
//  Created by Patricia Fiona on 14/12/22.
//

import Core
import Combine
import Alamofire
import Foundation
 
public struct GetGenresRemoteDataSource {
  let apiKey = Bundle.main.infoDictionary?["API_KEY"] as! String
  let orderByRatingAsc = "rating"
  let orderByRatingDesc = "-rating"
  let page = "1"
  
  public init() {
  }
  
  func getListGenres() -> AnyPublisher<[GenreResult], Error> {
    return Future<[GenreResult], Error> { completion in
      if let url = URL(string: "https://api.rawg.io/api/genres") {
        AF.request(
          url,
          method: .get,
          parameters: ["key": apiKey]
        )
        .validate()
        .responseDecodable(of: GenreResponse.self) { response in
          switch response.result {
          case .success(let value):
            completion(.success(value.results!))
          case .failure:
            completion(.failure(URLError.invalidResponse))
          }
        }
      }
    }.eraseToAnyPublisher()
  }
  
  func getGenreDetails(id: Int) -> AnyPublisher<DetailGenreResponse, Error> {
    return Future<DetailGenreResponse, Error> { completion in
      if let url = URL(string: "https://api.rawg.io/api/genres\(id)") {
        AF.request(
          url,
          method: .get,
          parameters: ["key": apiKey]
        )
        .validate()
        .responseDecodable(of: DetailGenreResponse.self) { response in
          switch response.result {
          case .success(let value):
            completion(.success(value))
          case .failure:
            completion(.failure(URLError.invalidResponse))
          }
        }
      }
    }.eraseToAnyPublisher()
  }
  
}
