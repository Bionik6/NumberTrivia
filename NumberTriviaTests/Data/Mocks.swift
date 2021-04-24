//
//  Mocks.swift
//  NumberTriviaTests
//
//  Created by Ibrahima Ciss on 23/04/2021.
//

import Foundation
@testable import NumberTrivia

// MARK: - NetworkInfoMock -

final class NetworkInfoMock: NetworkInfo {

  // MARK: - isConnected
  var isConnected: Bool {
    get { underlyingIsConnected }
    set(value) { underlyingIsConnected = value }
  }
  private var underlyingIsConnected: Bool!
}


// MARK: - NumberTriviaRepositoryMock -

final class NumberTriviaRepositoryMock: NumberTriviaRepository {
  
  // MARK: - getConcreteNumberTrivia
  var getConcreteNumberTriviaNumberResponseCallsCount = 0
  var getConcreteNumberTriviaNumberResponseCalled: Bool {
    getConcreteNumberTriviaNumberResponseCallsCount > 0
  }
  var getConcreteNumberTriviaNumberResponseReceivedArguments: (number: Double, completion: NumberTriviaResponse)?
  var getConcreteNumberTriviaNumberResponseReceivedInvocations: [(number: Double, completion: NumberTriviaResponse)] = []
  var getConcreteNumberTriviaNumberResponseClosure: ((Double, @escaping NumberTriviaResponse) -> Void)?
  
  func getConcreteNumberTrivia(number: Double, completion: @escaping NumberTriviaResponse) {
    getConcreteNumberTriviaNumberResponseCallsCount += 1
    getConcreteNumberTriviaNumberResponseReceivedArguments = (number: number, completion: completion)
    getConcreteNumberTriviaNumberResponseReceivedInvocations.append((number: number, completion: completion))
    getConcreteNumberTriviaNumberResponseClosure?(number, completion)
  }
  
  // MARK: - getRandomNumberTrivia
  
  var getRandomNumberTriviaResponseCallsCount = 0
  var getRandomNumberTriviaResponseCalled: Bool {
    getRandomNumberTriviaResponseCallsCount > 0
  }
  var getRandomNumberTriviaResponseReceivedResponse: NumberTriviaResponse?
  var getRandomNumberTriviaResponseReceivedInvocations: [NumberTriviaResponse] = []
  var getRandomNumberTriviaResponseClosure: ((@escaping NumberTriviaResponse) -> Void)?
  
  func getRandomNumberTrivia(completion: @escaping NumberTriviaResponse) {
    getRandomNumberTriviaResponseCallsCount += 1
    getRandomNumberTriviaResponseReceivedResponse = completion
    getRandomNumberTriviaResponseReceivedInvocations.append(completion)
    getRandomNumberTriviaResponseClosure?(completion)
  }
}



// MARK: - NumberTriviaRemoteDataSourceMock -

final class NumberTriviaRemoteDataSourceMock: NumberTriviaRemoteDataSource {
  
  // MARK: - getRandomNumberTrivia
  
  var getRandomNumberTriviaCompletionCallsCount = 0
  var getRandomNumberTriviaCompletionCalled: Bool {
    getRandomNumberTriviaCompletionCallsCount > 0
  }
  var getRandomNumberTriviaCompletionReceivedCompletion: (NumberTriviaRemoteResult)?
  var getRandomNumberTriviaCompletionReceivedInvocations: [(NumberTriviaRemoteResult)] = []
  var getRandomNumberTriviaCompletionClosure: ((@escaping NumberTriviaRemoteResult) -> Void)?
  
  func getRandomNumberTrivia(completion: @escaping NumberTriviaRemoteResult) {
    getRandomNumberTriviaCompletionCallsCount += 1
    getRandomNumberTriviaCompletionReceivedCompletion = completion
    getRandomNumberTriviaCompletionReceivedInvocations.append(completion)
    getRandomNumberTriviaCompletionClosure?(completion)
  }
  
  // MARK: - getConcreteNumberTrivia
  
  var getConcreteNumberTriviaNumberCompletionCallsCount = 0
  var getConcreteNumberTriviaNumberCompletionCalled: Bool {
    getConcreteNumberTriviaNumberCompletionCallsCount > 0
  }
  var getConcreteNumberTriviaNumberCompletionReceivedArguments: (number: Double, completion: NumberTriviaRemoteResult)!
  var getConcreteNumberTriviaNumberCompletionReceivedInvocations: [(number: Double, completion: NumberTriviaRemoteResult)] = []
  var getConcreteNumberTriviaNumberCompletionClosure: ((Double, @escaping NumberTriviaRemoteResult) -> Void)!
  
  func getConcreteNumberTrivia(number: Double, completion: @escaping NumberTriviaRemoteResult) {
    getConcreteNumberTriviaNumberCompletionCallsCount += 1
    getConcreteNumberTriviaNumberCompletionReceivedArguments = (number: number, completion: completion)
    getConcreteNumberTriviaNumberCompletionReceivedInvocations.append((number: number, completion: completion))
    getConcreteNumberTriviaNumberCompletionClosure?(number, completion)
  }
}



// MARK: - NumberTriviaLocalDataSourceMock -

final class NumberTriviaLocalDataSourceMock: NumberTriviaLocalDataSource {

  // MARK: - getLastNumberTrivia

  var getLastNumberTriviaCompletionCallsCount = 0
  var getLastNumberTriviaCompletionCalled: Bool {
    getLastNumberTriviaCompletionCallsCount > 0
  }
  var getLastNumberTriviaCompletionReceivedCompletion: ((Result<NumberTriviaModel, CachingError>) -> ())?
  var getLastNumberTriviaCompletionReceivedInvocations: [((Result<NumberTriviaModel, CachingError>) -> ())] = []
  var getLastNumberTriviaCompletionClosure: ((@escaping (Result<NumberTriviaModel, CachingError>) -> ()) -> Void)?

  func getLastNumberTrivia(completion: @escaping (Result<NumberTriviaModel, CachingError>) -> ()) {
    getLastNumberTriviaCompletionCallsCount += 1
    getLastNumberTriviaCompletionReceivedCompletion = completion
    getLastNumberTriviaCompletionReceivedInvocations.append(completion)
    getLastNumberTriviaCompletionClosure?(completion)
  }

  // MARK: - cache

  var cacheNumberTriviaCompletionCallsCount = 0
  var cacheNumberTriviaCompletionCalled: Bool {
    cacheNumberTriviaCompletionCallsCount > 0
  }
  var cacheNumberTriviaCompletionReceivedArguments: (numberTrivia: NumberTriviaModel, completion: () -> ())?
  var cacheNumberTriviaCompletionReceivedInvocations: [(numberTrivia: NumberTriviaModel, completion: () -> ())] = []
  var cacheNumberTriviaCompletionClosure: ((NumberTriviaModel, @escaping () -> ()) -> Void)?

  func cache(numberTrivia: NumberTriviaModel, completion: @escaping () -> ()) {
    cacheNumberTriviaCompletionCallsCount += 1
    cacheNumberTriviaCompletionReceivedArguments = (numberTrivia: numberTrivia, completion: completion)
    cacheNumberTriviaCompletionReceivedInvocations.append((numberTrivia: numberTrivia, completion: completion))
    cacheNumberTriviaCompletionClosure?(numberTrivia, completion)
  }
}
