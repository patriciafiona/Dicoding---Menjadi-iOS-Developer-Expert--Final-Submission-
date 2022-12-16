//
//  File.swift
//  
//
//  Created by Patricia Fiona on 11/12/22.
//

import Core
import Combine
import Alamofire
import Foundation
 
public struct GetGamesRemoteDataSource {
  let apiKey = Bundle.main.infoDictionary?["API_KEY"] as! String
  let orderByRatingAsc = "rating"
  let orderByRatingDesc = "-rating"
  let page = "1"
  
  public init() {
  }
  
  func getAllDiscoveryGame(sortFromBest: Bool) -> AnyPublisher<[GameResult], Error> {
    let param = ["key": apiKey, "ordering": sortFromBest == true ? orderByRatingDesc: orderByRatingAsc]
    return Future<[GameResult], Error> { completion in
      if let url = URL(string: "https://api.rawg.io/api/games") {
        AF.request(
          url,
          method: .get,
          parameters: param
        )
        .validate()
        .responseDecodable(of: GameResponse.self) { response in
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
  
  func getFewDiscoveryGame() -> AnyPublisher<[GameResult], Error> {
    return Future<[GameResult], Error> { completion in
      if let url = URL(string: "https://api.rawg.io/api/games") {
        AF.request(
          url,
          method: .get,
          parameters: ["key": apiKey, "ordering": orderByRatingDesc, "page_size": "10"]
        )
        .validate()
        .responseDecodable(of: GameResponse.self) { response in
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
  
  func getGameDetails(id: Int) -> AnyPublisher<DetailGameResponse, Error>{
    return Future<DetailGameResponse, Error> { completion in
      if let url = URL(string: "https://api.rawg.io/api/games/\(id)") {
        AF.request(
          url,
          method: .get,
          parameters: ["key": apiKey]
        )
        .validate()
        .responseDecodable(of: DetailGameResponse.self) { response in
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
