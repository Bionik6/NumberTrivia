//
//  GetConcreteRandomTriviaUseCaseTests.swift
//  NumberTriviaTests
//
//  Created by Ibrahima Ciss on 22/04/2021.
//

import XCTest
@testable import NumberTrivia


class GetRandomNumberTriviaUseCaseTests: XCTestCase {
  
  private var tNumberTrivia: NumberTrivia!
  private var useCase: GetRandomNumberTriviaUseCase!
  private var result: Result<NumberTrivia, NumberTriviaError>?
  private var mockNumberTriviaRepository: NumberTriviaRepositoryMock!
  
  override func setUpWithError() throws {
    mockNumberTriviaRepository = NumberTriviaRepositoryMock()
    tNumberTrivia = NumberTrivia(number: 10, text: "test")
    useCase = GetRandomNumberTriviaUseCase(repository: mockNumberTriviaRepository)
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
    useCase(params: NoParam()) { self.result = $0 }
    
    // Then
    XCTAssertEqual(mockNumberTriviaRepository.numberTrivia, tNumberTrivia)
    XCTAssertEqual(mockNumberTriviaRepository.getRandomNumberTriviaResponseCalled, true)
    XCTAssertEqual(mockNumberTriviaRepository.getRandomNumberTriviaResponseCallsCount, 1)
    
    // When
    useCase(params: NoParam()) { _ in expectation.fulfill() }
    
    // Then
    waitForExpectations(timeout: 1)
    
    XCTAssertEqual(result, .success(tNumberTrivia))
    XCTAssertEqual(mockNumberTriviaRepository.response, .success(tNumberTrivia))
    XCTAssertEqual(mockNumberTriviaRepository.getRandomNumberTriviaResponseCallsCount, 2)
  }
  
}
