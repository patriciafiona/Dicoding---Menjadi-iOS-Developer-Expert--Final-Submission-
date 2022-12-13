import Foundation
import Combine

public protocol DataSource {
    associatedtype Request
    associatedtype Response
    
    func execute(request: Request?) -> AnyPublisher<Response, Error>
    func execute(request: Request?, keyword: String) -> AnyPublisher<Response, Error>
  func execute(request: Request?, id: Int, isFavorite: Bool) -> AnyPublisher<Response, Error>
}

