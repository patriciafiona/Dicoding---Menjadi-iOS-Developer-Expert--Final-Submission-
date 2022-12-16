//
//  File.swift
//  
//
//  Created by Patricia Fiona on 15/12/22.
//

import Core
import Combine
import Alamofire
import Foundation

public struct GetDevelopersRemoteDataSource : DataSource {
    let apiKey = Bundle.main.infoDictionary?["API_KEY"] as! String
  
    public typealias Request = Any
    
    public typealias Response = [DeveloperResult]
    
    private let _endpoint: String
    
    public init(endpoint: String) {
        _endpoint = endpoint
    }
    
    public func execute(request: Any?) -> AnyPublisher<[DeveloperResult], Error> {
      let param = ["key": apiKey]
        return Future<[DeveloperResult], Error> { completion in
          print("URL: \(_endpoint)")
          if let url = URL(string: _endpoint) {
            AF.request(
              url,
              method: .get,
              parameters: param
            )
              .validate()
              .responseDecodable(of: DeveloperResponse.self) { response in
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
  
    public func execute(request: Request?, keyword: String) -> AnyPublisher<[DeveloperResult], Error> {
      fatalError()
    }
    
    public func execute(request: Request?, id: Int, isFavorite: Bool) -> AnyPublisher<[DeveloperResult], Error> {
      fatalError()
    }
}
