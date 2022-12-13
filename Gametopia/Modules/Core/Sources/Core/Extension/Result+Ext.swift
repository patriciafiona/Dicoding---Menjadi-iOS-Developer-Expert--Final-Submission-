import RealmSwift

extension Results {

  public func toArray<T>(ofType: T.Type) -> [T] {
    var array = [T]()
    for index in 0 ..< count {
      if let result = self[index] as? T {
        array.append(result)
      }
    }
    return array
  }
  
  public func toArray<T>(ofType: T.Type, limits: Int) -> [T] {
    var array = [T]()
    if(count != 0){
      for index in 0 ..< limits {
        if let result = self[index] as? T {
          array.append(result)
        }
      }
    }
    return array
  }
}

