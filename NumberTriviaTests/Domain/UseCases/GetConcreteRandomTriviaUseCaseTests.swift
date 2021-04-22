//
//  GetConcreteRandomTriviaUseCaseTests.swift
//  NumberTriviaTests
//
//  Created by Ibrahima Ciss on 22/04/2021.
//

import XCTest
@testable import NumberTrivia


class GetConcreteRandomTriviaUseCaseTests: XCTestCase {
  
  private var tNumber = 2
  private var tNumberTrivia: NumberTrivia!
  private var useCase: GetConcreteNumberTriviaUseCase!
  private var result: Result<NumberTrivia, NumberTriviaError>?
  private var mockNumberTriviaRepository: NumberTriviaRepositoryMock!
  
  override func setUpWithError() throws {
    mockNumberTriviaRepository = NumberTriviaRepositoryMock()
    tNumberTrivia = NumberTrivia(number: tNumber, text: "test")
    useCase = GetConcreteNumberTriviaUseCase(repository: mockNumberTriviaRepository)
  }
  
  override func tearDownWithError() throws {
    result = nil
    useCase = nil
    tNumberTrivia = nil
    mockNumberTriviaRepository = nil
  }
  
  func testSutShouldGetNumberTriviaFromRepository() {
    // Given
    let expectation = expectation(description: #function)
    
    // When
    useCase(params: NumberTriviaParam(value: tNumber)) { self.result = $0 }
    
    // Then
    XCTAssertEqual(mockNumberTriviaRepository.numberTrivia, tNumberTrivia)
    XCTAssertEqual(mockNumberTriviaRepository.getConcreteNumberTriviaNumberResponseCalled, true)
    XCTAssertEqual(mockNumberTriviaRepository.getConcreteNumberTriviaNumberResponseCallsCount, 1)
    
    // When
    useCase(params: NumberTriviaParam(value: tNumber)) { _ in expectation.fulfill() }
    
    // Then
    waitForExpectations(timeout: 1)
    
    XCTAssertEqual(result, .success(tNumberTrivia))
    XCTAssertEqual(mockNumberTriviaRepository.response, .success(tNumberTrivia))
    XCTAssertEqual(mockNumberTriviaRepository.getConcreteNumberTriviaNumberResponseCallsCount, 2)
    XCTAssertEqual(mockNumberTriviaRepository.getConcreteNumberTriviaNumberResponseReceivedArguments?.number, tNumber)
  }
  
}
