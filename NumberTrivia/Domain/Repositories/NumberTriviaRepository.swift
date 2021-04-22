//
//  NumberTriviaRepository.swift
//  NumberTrivia
//
//  Created by Ibrahima Ciss on 21/04/2021.
//

import Foundation

protocol NumberTriviaRepository {
  func getConcreteNumberTrivia(number: Int, response: @escaping NumberTriviaResponse)
  func getRandomNumberTrivia(number: Int, response: @escaping NumberTriviaResponse)
}
