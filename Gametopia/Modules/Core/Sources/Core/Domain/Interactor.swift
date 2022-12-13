import Foundation
import Combine

public struct Interactor<Request, Response, R: Repository>: UseCase
where R.Request == Request, R.Response == Response {
    
    private let _repository: R
    
    public init(repository: R) {
        _repository = repository
    }
    
    public func execute(request: Request?) -> AnyPublisher<Response, Error> {
        _repository.execute(request: request)
    }
  
    public func execute(request: Request?, keyword: String) -> AnyPublisher<Response, Error> {
      _repository.execute(request: request, keyword: keyword)
    }
  
    public func execute(request: Request?, id: Int, isFavorite: Bool) -> AnyPublisher<Bool, Error> {
      _repository.execute(request: request, id: id, isFavorite: isFavorite)
    }
}

