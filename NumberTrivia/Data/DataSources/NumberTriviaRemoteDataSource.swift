//
//  NumberTriviaRemoteDataSource.swift
//  NumberTrivia
//
//  Created by Ibrahima Ciss on 23/04/2021.
//

import Foundation

protocol NumberTriviaRemoteDataSource {
  func getRandomNumberTrivia(response: @escaping (NumberTriviaModel) -> ())
  func getConcreteNumberTrivia(number: Double, response: @escaping (NumberTriviaModel) -> ())
}
