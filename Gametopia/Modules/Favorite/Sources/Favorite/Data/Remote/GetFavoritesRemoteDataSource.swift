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
 
public struct GetFavoritesRemoteDataSource : DataSource {
    public typealias Request = Any
    
    public typealias Response = [GameResult]
    
    private let _endpoint: String
    
    public init(endpoint: String) {
        _endpoint = endpoint
    }
    
    public func execute(request: Any?) -> AnyPublisher<[GameResult], Error> {
        return Future<[GameResult], Error> { completion in
          if let url = URL(string: _endpoint) {
            AF.request(url)
              .validate()
              .responseDecodable(of: FavoritesResponse.self) { response in
                switch response.result {
                case .success(let value):
                  completion(.success(value.games.results ?? []))
                case .failure:
                  completion(.failure(URLError.invalidResponse))
                }
              }
          }
        }.eraseToAnyPublisher()
    }
}
