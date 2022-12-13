import Foundation
import Combine

public protocol DataSource {
    associatedtype Request
    associatedtype Response
    
    func execute(request: Request?) -> AnyPublisher<Response, Error>
    func executeSearch(request: Request?, keyword: String) -> AnyPublisher<Response, Error>
}

