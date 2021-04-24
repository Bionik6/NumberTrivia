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
    // Given
    let expectation = expectation(description: #function)
    
    mockNumberTriviaRepository.getConcreteNumberTriviaNumberResponseClosure = { number, completion in
      let numberTrivia = NumberTrivia(number: number, text: "test")
      completion(.success(numberTrivia))
    }
    
    // When
    useCase(params: NumberTriviaParam(value: tNumber)) { _ in }
    
    // Then
    // XCTAssertEqual(mockNumberTriviaRepository.numberTrivia, tNumberTrivia)
    XCTAssertEqual(mockNumberTriviaRepository.getConcreteNumberTriviaNumberResponseCalled, true)
    XCTAssertEqual(mockNumberTriviaRepository.getConcreteNumberTriviaNumberResponseCallsCount, 1)
    
    // When
    useCase(params: NumberTriviaParam(value: tNumber)) { _ in expectation.fulfill() }
    
    // Then
    waitForExpectations(timeout: 1)
    XCTAssertEqual(mockNumberTriviaRepository.getConcreteNumberTriviaNumberResponseCallsCount, 2)
    XCTAssertEqual(mockNumberTriviaRepository.getConcreteNumberTriviaNumberResponseReceivedArguments?.number, tNumber)
  }
  
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
