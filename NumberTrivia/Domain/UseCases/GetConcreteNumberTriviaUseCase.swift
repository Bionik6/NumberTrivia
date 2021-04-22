//
//  GetConcreteNumberTriviaUseCase.swift
//  NumberTrivia
//
//  Created by Ibrahima Ciss on 22/04/2021.
//

import Foundation

struct NumberTriviaParam {
  private(set) var value: Int
  
  init(value: Int) {
    self.value = value
  }
}


class GetConcreteNumberTriviaUseCase: UseCase {
  
  typealias T = NumberTrivia
  typealias Params = NumberTriviaParam
  
  private let repository: NumberTriviaRepository
  
  init(repository: NumberTriviaRepository) {
    self.repository = repository
  }
  
  func callAsFunction(params: NumberTriviaParam, completion: @escaping NumberTriviaResponse) {
    repository.getConcreteNumberTrivia(number: params.value) { completion($0) }
  }
  
}
