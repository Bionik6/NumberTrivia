//
//  NumberTriviaRemoteDataSource.swift
//  NumberTrivia
//
//  Created by Ibrahima Ciss on 23/04/2021.
//

import Foundation

enum NumberTriviaResponseError: LocalizedError {
  case serverFailure
}

typealias NumberTriviaRemoteResult = (Result<NumberTriviaModel, NumberTriviaResponseError>) -> ()

protocol NumberTriviaRemoteDataSource {
  func getRandomNumberTrivia(completion: @escaping NumberTriviaRemoteResult)
  func getConcreteNumberTrivia(number: Double, completion: @escaping NumberTriviaRemoteResult)
}
