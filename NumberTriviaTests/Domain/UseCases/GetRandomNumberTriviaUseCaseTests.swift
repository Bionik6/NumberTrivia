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
  private var mockNumberTriviaRepository: NumberTriviaRepositoryMock!
  
  override func setUpWithError() throws {
    mockNumberTriviaRepository = NumberTriviaRepositoryMock()
    tNumberTrivia = NumberTrivia(number: 10, text: "test")
    useCase = GetRandomNumberTriviaUseCase(repository: mockNumberTriviaRepository)
  }
  
  override func tearDownWithError() throws {
    useCase = nil
    tNumberTrivia = nil
    mockNumberTriviaRepository = nil
  }
  
  func testSutShouldGetNumberTriviaFromRepository() {
    let expectation = expectation(description: #function)
    mockNumberTriviaRepository.getRandomNumberTriviaResponseClosure = { completion in
      let numberTrivia = NumberTrivia(number: 1, text: "test")
      completion(.success(numberTrivia))
    }
    
    useCase(params: NoParam()) { _ in }
    
    XCTAssertEqual(mockNumberTriviaRepository.getRandomNumberTriviaResponseCalled, true)
    XCTAssertEqual(mockNumberTriviaRepository.getRandomNumberTriviaResponseCallsCount, 1)
    
    useCase(params: NoParam()) { _ in expectation.fulfill() }
    
    waitForExpectations(timeout: 1)
    XCTAssertEqual(mockNumberTriviaRepository.getRandomNumberTriviaResponseCallsCount, 2)
  }
  
}
