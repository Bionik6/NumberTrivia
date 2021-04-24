//
//  GetConcreteNumberTriviaTests.swift
//  NumberTriviaTests
//
//  Created by Ibrahima Ciss on 21/04/2021.
//

import XCTest
@testable import NumberTrivia


class GetConcreteNumberTriviaUseCaseTests: XCTestCase {
  
  private var tNumber: Double = 2.0
  private var tNumberTrivia: NumberTrivia!
  private var useCase: GetConcreteNumberTriviaUseCase!
  private var mockNumberTriviaRepository: NumberTriviaRepositoryMock!
  
  override func setUpWithError() throws {
    mockNumberTriviaRepository = NumberTriviaRepositoryMock()
    tNumberTrivia = NumberTrivia(number: tNumber, text: "test")
    useCase = GetConcreteNumberTriviaUseCase(repository: mockNumberTriviaRepository)
  }
  
  override func tearDownWithError() throws {
    useCase = nil
    tNumberTrivia = nil
    mockNumberTriviaRepository = nil
  }
  
  func testSutShouldGetNumberTriviaFromRepository() {
    let expectation = expectation(description: #function)
    mockNumberTriviaRepository.getConcreteNumberTriviaNumberResponseClosure = { number, completion in
      let numberTrivia = NumberTrivia(number: number, text: "test")
      completion(.success(numberTrivia))
    }
    
    useCase(params: NumberTriviaParam(value: tNumber)) { _ in }
    
    XCTAssertEqual(mockNumberTriviaRepository.getConcreteNumberTriviaNumberResponseCalled, true)
    XCTAssertEqual(mockNumberTriviaRepository.getConcreteNumberTriviaNumberResponseCallsCount, 1)
    
    useCase(params: NumberTriviaParam(value: tNumber)) { _ in expectation.fulfill() }
    
    waitForExpectations(timeout: 1)
    XCTAssertEqual(mockNumberTriviaRepository.getConcreteNumberTriviaNumberResponseCallsCount, 2)
    XCTAssertEqual(mockNumberTriviaRepository.getConcreteNumberTriviaNumberResponseReceivedArguments?.number, tNumber)
  }
  
}
