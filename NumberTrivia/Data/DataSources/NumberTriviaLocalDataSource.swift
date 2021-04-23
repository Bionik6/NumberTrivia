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
