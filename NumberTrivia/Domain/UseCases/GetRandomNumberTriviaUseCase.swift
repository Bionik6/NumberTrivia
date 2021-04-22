//
//  GetRandomNumberTriviaUseCase.swift
//  NumberTrivia
//
//  Created by Ibrahima Ciss on 22/04/2021.
//

import Foundation

final class GetRandomNumberTriviaUseCase: UseCase {
  
  typealias T = NumberTrivia
  typealias Params = NoParam
  
  private(set) var repository: NumberTriviaRepository
  
  init(repository: NumberTriviaRepository) {
    self.repository = repository
  }
  
  func callAsFunction(params: NoParam, completion: @escaping NumberTriviaResponse) {
    repository.getRandomNumberTrivia { completion($0) }
  }
  
}
