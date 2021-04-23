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
    self.remoteDataSource = remoteDataSource
    self.localDataSource = localDataSource
  }
  
  func getRandomNumberTrivia(completion: @escaping NumberTriviaResponse) {
    
  }
  
  func getConcreteNumberTrivia(number: Double, completion: @escaping NumberTriviaResponse) {
    completion(.success(NumberTrivia(number: 1, text: "hello")))
  }
  
}


