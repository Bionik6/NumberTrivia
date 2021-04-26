//
//  NumberTriviaLocalDataSource.swift
//  NumberTrivia
//
//  Created by Ibrahima Ciss on 23/04/2021.
//

import Foundation

enum CachingError: LocalizedError {
  case noDataPresent
}

protocol NumberTriviaLocalDataSource {
  func getLastNumberTrivia(completion: @escaping (Result<NumberTriviaModel, CachingError>) -> ())
  func cache(numberTrivia: NumberTriviaModel, completion: @escaping () -> ())
}


class UserDefaultsLocalDataSource: NumberTriviaLocalDataSource {
  
  static var key = "lastStoredNumberTrivia"
  
  private(set) var userDefaults: UserDefaults

  init(userDefaults: UserDefaults) {
    self.userDefaults = userDefaults
  }
  
  func getLastNumberTrivia(completion: @escaping (Result<NumberTriviaModel, CachingError>) -> ()) {
    let data = userDefaults.data(forKey: Self.key)
    if let data = data, let model = try? JSONDecoder().decode(NumberTriviaModel.self, from: data) {
      completion(.success(model))
    }
    if data == nil { completion(.failure(.noDataPresent)) }
  }
  
  func cache(numberTrivia: NumberTriviaModel, completion: @escaping () -> ()) {
    guard let data = numberTrivia.toJSON().data(using: .utf8) else {
      fatalError("couldn't turn json string to data")
    }
    userDefaults.set(data, forKey: Self.key)
    completion()
  }
  
}
