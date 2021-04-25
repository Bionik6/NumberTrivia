 //
 //  NumberTriviaRepositoryImplementation.swift
 //  NumberTrivia
 //
 //  Created by Ibrahima Ciss on 23/04/2021.
 //
 
 import Foundation
 
 struct NumberTriviaRepositoryImplementation: NumberTriviaRepository {
  
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
    getNumberTrivia(completion: completion) {
      remoteDataSource.getRandomNumberTrivia { handle(response: $0, completion: completion) }
    }
  }
  
  func getConcreteNumberTrivia(number: Double, completion: @escaping NumberTriviaResponse) {
    getNumberTrivia(completion: completion) {
      remoteDataSource.getConcreteNumberTrivia(number: number) { handle(response: $0, completion: completion) }
    }
  }
  
 }
 
 
 extension NumberTriviaRepositoryImplementation {
  
  private func getNumberTrivia(completion: @escaping NumberTriviaResponse, block: @escaping ()->()) {
    networkInfo.isConnected { connected in
      guard connected else {
        localDataSource.getLastNumberTrivia { response in
          if case .success(let model) = response { completion(.success(NumberTrivia(number: model.number, text: model.text))) }
          if case .failure(let error) = response { if error == .noDataPresent { completion(.failure(.noCacheDataPresent)) } }
        }
        return
      }
      block()
    }
  }
  
  private func handle(response: Result<NumberTriviaModel, NumberTriviaResponseError>, completion: @escaping NumberTriviaResponse) {
    if case .success(let model) = response {
      localDataSource.cache(numberTrivia: model) { }
      completion(.success(NumberTrivia(number: model.number, text: model.text)))
    }
    if case .failure = response { completion(.failure(.basic)) }
  }
  
 }
