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
  
  func test_sut_should_check_if_the_device_is_online() {
    let promise = XCTestExpectation(description: #function)
    networkInfo.isConnected = true
    sut.getConcreteNumberTrivia(number: tNumber) { _ in
      promise.fulfill()
    }
    wait(for: [promise], timeout: 1.0)
    XCTAssertEqual(networkInfo.isConnected, true)
  }
  
}
