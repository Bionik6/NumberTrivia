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
    guard networkInfo.isConnected else {
      localDataSource.getLastNumberTrivia { response in
        if case .success(let model) = response { completion(.success(NumberTrivia(number: model.number, text: model.text))) }
        if case .failure(let error) = response { if error == .noDataPresent { completion(.failure(.noCacheDataPresent)) } }
      }
      return
    }
    remoteDataSource.getRandomNumberTrivia { response in
      if case .success(let model) = response {
        self.localDataSource.cache(numberTrivia: model) { }
        completion(.success(NumberTrivia(number: model.number, text: model.text)))
      }
      if case .failure = response { completion(.failure(.basic)) }
    }
  }

  func getConcreteNumberTrivia(number: Double, completion: @escaping NumberTriviaResponse) {
    guard networkInfo.isConnected else {
      localDataSource.getLastNumberTrivia { response in
        if case .success(let model) = response { completion(.success(NumberTrivia(number: model.number, text: model.text))) }
        if case .failure(let error) = response { if error == .noDataPresent { completion(.failure(.noCacheDataPresent)) } }
      }
      return
    }
    remoteDataSource.getConcreteNumberTrivia(number: number) { response in
      if case .success(let model) = response {
        self.localDataSource.cache(numberTrivia: model) { }
        completion(.success(NumberTrivia(number: model.number, text: model.text)))
      }
      if case .failure = response { completion(.failure(.basic)) }
    }
  }

}
