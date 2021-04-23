//
//  NumberTriviaRepository.swift
//  NumberTrivia
//
//  Created by Ibrahima Ciss on 21/04/2021.
//

import Foundation

protocol NumberTriviaRepository {
  func getRandomNumberTrivia(completion: @escaping NumberTriviaResponse)
  func getConcreteNumberTrivia(number: Double, completion: @escaping NumberTriviaResponse)
}
