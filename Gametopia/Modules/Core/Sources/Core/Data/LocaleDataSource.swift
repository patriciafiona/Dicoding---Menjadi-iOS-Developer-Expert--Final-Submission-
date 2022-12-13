import Foundation
import Combine

public protocol LocaleDataSource {
    associatedtype Request
    associatedtype Response
    
    func list(request: Request?) -> AnyPublisher<[Response], Error>
    func add(entities: [Response]) -> AnyPublisher<Bool, Error>
    func add(entities: Response) -> AnyPublisher<Bool, Error>
    func get(id: String) -> AnyPublisher<Response, Error>
    func update(id: Int, entity: Response) -> AnyPublisher<Bool, Error>
  
    //Favorite Section
    func update(id: Int, isFavorite: Bool) -> AnyPublisher<Bool, Error>
  
    //Game Section
    func list(sortedFromBest: Bool) -> AnyPublisher<[Response], Error>
    func listBestRating() -> AnyPublisher<[Response], Error>
    func add(entity: Response) -> AnyPublisher<Bool, Error>
    func updateGames(entity: Response) -> AnyPublisher<Bool, Error>
}
