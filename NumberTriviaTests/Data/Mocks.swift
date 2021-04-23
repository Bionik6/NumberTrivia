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


// MARK: - NumberTriviaRemoteDataSourceMock -

final class NumberTriviaRemoteDataSourceMock: NumberTriviaRemoteDataSource {
  
  // MARK: - getRandomNumberTrivia
  
  var getRandomNumberTriviaResponseCallsCount = 0
  var getRandomNumberTriviaResponseCalled: Bool {
    getRandomNumberTriviaResponseCallsCount > 0
  }
  var getRandomNumberTriviaResponseReceivedResponse: ((NumberTriviaModel) -> ())?
  var getRandomNumberTriviaResponseReceivedInvocations: [((NumberTriviaModel) -> ())] = []
  var getRandomNumberTriviaResponseClosure: ((@escaping (NumberTriviaModel) -> ()) -> Void)?
  
  func getRandomNumberTrivia(response: @escaping (NumberTriviaModel) -> ()) {
    getRandomNumberTriviaResponseCallsCount += 1
    getRandomNumberTriviaResponseReceivedResponse = response
    getRandomNumberTriviaResponseReceivedInvocations.append(response)
    getRandomNumberTriviaResponseClosure?(response)
  }
  
  // MARK: - getConcreteNumberTrivia
  
  var getConcreteNumberTriviaNumberResponseCallsCount = 0
  var getConcreteNumberTriviaNumberResponseCalled: Bool {
    getConcreteNumberTriviaNumberResponseCallsCount > 0
  }
  var getConcreteNumberTriviaNumberResponseReceivedArguments: (number: Double, response: (NumberTriviaModel) -> ())?
  var getConcreteNumberTriviaNumberResponseReceivedInvocations: [(number: Double, response: (NumberTriviaModel) -> ())] = []
  var getConcreteNumberTriviaNumberResponseClosure: ((Double, @escaping (NumberTriviaModel) -> ()) -> Void)?
  
  func getConcreteNumberTrivia(number: Double, response: @escaping (NumberTriviaModel) -> ()) {
    getConcreteNumberTriviaNumberResponseCallsCount += 1
    getConcreteNumberTriviaNumberResponseReceivedArguments = (number: number, response: response)
    getConcreteNumberTriviaNumberResponseReceivedInvocations.append((number: number, response: response))
    getConcreteNumberTriviaNumberResponseClosure?(number, response)
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
