//
//  NumberTriviaRepositoryImplementation.swift
//  NumberTrivia
//
//  Created by Ibrahima Ciss on 23/04/2021.
//

import Foundation

final class NumberTriviaRepositoryImplementation: NumberTriviaRepository {

  private(set) var networkInfo: NetworkInfo
  private(set) var remoteDataSource: NumberTriviaRemoteDataSource
  private(set) var localDataSource: NumberTriviaLocalDataSource

  init(networkInfo: NetworkInfo,
       remoteDataSource: NumberTriviaRemoteDataSource,
       localDataSource: NumberTriviaLocalDataSource)
  {
    self.networkInfo = networkInfo
    self.localDataSource = localDataSource
    self.remoteDataSource = remoteDataSource
  }

  func getRandomNumberTrivia(completion: @escaping NumberTriviaResponse) {

  }

  func getConcreteNumberTrivia(number: Double, completion: @escaping NumberTriviaResponse) {
    remoteDataSource.getConcreteNumberTrivia(number: number) { result in
      switch result {
        case .success(let model):
          let numberTrivia = NumberTrivia(number: model.number, text: model.text)
          self.localDataSource.cache(numberTrivia: model) { }
          completion(.success(numberTrivia))
        case .failure:
          completion(.failure(.basic))
      }
    }
  }

}
