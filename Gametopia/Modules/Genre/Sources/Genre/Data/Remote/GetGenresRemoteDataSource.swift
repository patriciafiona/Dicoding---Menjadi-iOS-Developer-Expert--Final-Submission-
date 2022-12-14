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
      if let url = URL(string: Endpoints.Gets.genres.url) {
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
      if let url = URL(string: "\(Endpoints.Gets.genres.url)/\(id)") {
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

struct API {
  static let baseUrl = "https://api.rawg.io/api/"
}

protocol Endpoint {
  var url: String { get }
}

enum Endpoints {
  
  enum Gets: Endpoint {
    case games
    case genres
    case developers
    
    public var url: String {
      switch self {
      case .games: return "\(API.baseUrl)games"
      case .genres: return "\(API.baseUrl)genres"
      case .developers: return "\(API.baseUrl)developers"
      }
    }
  }
  
}
