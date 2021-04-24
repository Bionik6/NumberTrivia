//
//  NumberTriviaRepositoryImplementationTests.swift
//  NumberTriviaTests
//
//  Created by Ibrahima Ciss on 23/04/2021.
//

import XCTest
@testable import NumberTrivia

class NumberTriviaRepositoryImplementationTests: XCTestCase {
  
  private var sut: NumberTriviaRepositoryImplementation!
  private var networkInfo: NetworkInfoMock!
  private var localDataSource: NumberTriviaLocalDataSourceMock!
  private var remoteDataSource: NumberTriviaRemoteDataSourceMock!
  
  private let tNumber = 1.0
  private var tNumberTriviaModel: NumberTriviaModel!
  private var tNumberTrivia: NumberTrivia!
  
  override func setUpWithError() throws {
    networkInfo = NetworkInfoMock()
    localDataSource = NumberTriviaLocalDataSourceMock()
    remoteDataSource = NumberTriviaRemoteDataSourceMock()
    sut = NumberTriviaRepositoryImplementation(
      networkInfo: networkInfo,
      remoteDataSource: remoteDataSource,
      localDataSource: localDataSource
    )
    tNumberTriviaModel = NumberTriviaModel(number: tNumber, text: "test trivia")
    tNumberTrivia = NumberTrivia(number: tNumber, text: "test trivia")
  }
  
  override func tearDownWithError() throws {
    networkInfo = nil
    localDataSource = nil
    remoteDataSource = nil
    sut = nil
    tNumberTrivia = nil
    tNumberTriviaModel = nil
  }
  
  
  func test_sut_should_return_remote_data_when_the_call_to_remote_dataSource_is_successful() {
    let promise = XCTestExpectation(description: #function)
    remoteDataSource.getConcreteNumberTriviaNumberCompletionClosure = { (number: Double, completion: NumberTriviaRemoteResult) in
      let numberTrivia = NumberTriviaModel(number: number, text: "hello")
      completion(.success(numberTrivia))
    }
    
    sut.getConcreteNumberTrivia(number: 3.0) { _ in promise.fulfill() }
    
    wait(for: [promise], timeout: 1.0)
    XCTAssertTrue(remoteDataSource.getConcreteNumberTriviaNumberCompletionCalled)
    XCTAssertEqual(remoteDataSource.getConcreteNumberTriviaNumberCompletionCallsCount, 1)
    XCTAssertEqual(remoteDataSource.getConcreteNumberTriviaNumberCompletionReceivedArguments?.number, 3.0)
  }
  
  
  func test_sut_cache_data_locally_when_the_call_to_remote_data_source_is_successful() {
    let promise = XCTestExpectation(description: #function)
    remoteDataSource.getConcreteNumberTriviaNumberCompletionClosure = { (number: Double, completion: NumberTriviaRemoteResult) in
      let numberTrivia = NumberTriviaModel(number: number, text: "hello")
       completion(.success(numberTrivia))
    }
    
    sut.getConcreteNumberTrivia(number: 3.0) { _ in promise.fulfill() }
    
    wait(for: [promise], timeout: 1.0)
    XCTAssertTrue(remoteDataSource.getConcreteNumberTriviaNumberCompletionCalled)
    XCTAssertTrue(localDataSource.cacheNumberTriviaCompletionCalled)
    XCTAssertEqual(localDataSource.cacheNumberTriviaCompletionCallsCount, 1)
  }
  
  
  func test_sut_should_return_error_when_the_call_to_remote_dataSource_is_unsuccessful() {
    let promise = XCTestExpectation(description: #function)
    remoteDataSource.getConcreteNumberTriviaNumberCompletionClosure = { (number: Double, completion: NumberTriviaRemoteResult) in
      completion(.failure(.serverFailure))
    }

    sut.getConcreteNumberTrivia(number: 3.0) { _ in promise.fulfill() }

    wait(for: [promise], timeout: 1.0)
    XCTAssertTrue(remoteDataSource.getConcreteNumberTriviaNumberCompletionCalled)
    XCTAssertFalse(localDataSource.cacheNumberTriviaCompletionCalled)
    XCTAssertEqual(localDataSource.cacheNumberTriviaCompletionCallsCount, 0)
  }
  
  // Device is online
  // => Sut should return remote data when the call to remote data source is successful
  // => Sut should cache the data locally when the call to remote data source is successful
  // => Sut should return error when the call to remote data source is unsuccessful
  
}
