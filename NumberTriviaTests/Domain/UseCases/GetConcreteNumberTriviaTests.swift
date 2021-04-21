//
//  GetConcreteNumberTriviaTests.swift
//  NumberTriviaTests
//
//  Created by Ibrahima Ciss on 21/04/2021.
//

import XCTest
@testable import NumberTrivia


class GetConcreteNumberTrivia {
  
  private let repository: NumberTriviaRepository
  
  init(repository: NumberTriviaRepository) {
    self.repository = repository
  }
  
  func callAsFunction(number: Int, completion: @escaping (Result<NumberTrivia, NumberTriviaError>) -> Void) {
    repository.getConcreteNumberTrivia(number: number) { completion($0) }
  }
}


class GetConcreteNumberTriviaTests: XCTestCase {
  
  private var tNumber = 2
  private var tNumberTrivia: NumberTrivia!
  private var useCase: GetConcreteNumberTrivia!
  private var mockNumberTriviaRepository: NumberTriviaRepositoryMock!
  private var result: Result<NumberTrivia, NumberTriviaError>?
  
  override func setUpWithError() throws {
    // Put setup code here. This method is called before the invocation of each test method in the class.
    mockNumberTriviaRepository = NumberTriviaRepositoryMock()
    tNumberTrivia = NumberTrivia(number: tNumber, text: "test")
    useCase = GetConcreteNumberTrivia(repository: mockNumberTriviaRepository)
  }
  
  override func tearDownWithError() throws {
    mockNumberTriviaRepository = nil
    useCase = nil
  }
  
  func testSutShouldGetNumberTriviaFromRepository() {
    // Given
    let expectation = expectation(description: #function)
    
    // When
    useCase(number: tNumber) { response in
      self.result = response
    }
    
    // Then
    XCTAssertEqual(mockNumberTriviaRepository.numberTrivia, tNumberTrivia)
    XCTAssertEqual(mockNumberTriviaRepository.getConcreteNumberTriviaNumberResponseCallsCount, 1)
    XCTAssertEqual(mockNumberTriviaRepository.getConcreteNumberTriviaNumberResponseCalled, true)
    
    // When
    useCase(number: tNumber) { _ in expectation.fulfill() }
    
    // Then
    XCTAssertEqual(mockNumberTriviaRepository.getConcreteNumberTriviaNumberResponseCallsCount, 2)
    XCTAssertEqual(mockNumberTriviaRepository.getConcreteNumberTriviaNumberResponseReceivedArguments?.number, tNumber)
    XCTAssertEqual(mockNumberTriviaRepository.response, .success(tNumberTrivia))
    waitForExpectations(timeout: 1)
  }
  
}

// Adresse: Ngor Almadies, Villa Nº593, Dakar


// MARK: - NumberTriviaRepositoryMock -

final class NumberTriviaRepositoryMock: NumberTriviaRepository {
  
  var numberTrivia: NumberTrivia?
  var error: NumberTriviaError?
  var response: Result<NumberTrivia, NumberTriviaError>?
  
  // MARK: - getConcreteNumberTrivia
  var getConcreteNumberTriviaNumberResponseCallsCount = 0
  var getConcreteNumberTriviaNumberResponseCalled: Bool {
    getConcreteNumberTriviaNumberResponseCallsCount > 0
  }
  var getConcreteNumberTriviaNumberResponseReceivedArguments: (number: Int, response: NumberTriviaResponse)?
  var getConcreteNumberTriviaNumberResponseReceivedInvocations: [(number: Int, response: NumberTriviaResponse)] = []
  var getConcreteNumberTriviaNumberResponseClosure: ((Int, @escaping NumberTriviaResponse) -> Void)?
  
  func getConcreteNumberTrivia(number: Int, response: @escaping NumberTriviaResponse) {
    numberTrivia = NumberTrivia(number: number, text: "test")
    response(.success(numberTrivia!))
    self.response = .success(numberTrivia!)

    getConcreteNumberTriviaNumberResponseCallsCount += 1
    getConcreteNumberTriviaNumberResponseReceivedArguments = (number: number, response: response)
    getConcreteNumberTriviaNumberResponseReceivedInvocations.append((number: number, response: response))
    getConcreteNumberTriviaNumberResponseClosure?(number, response)
  }
  
  // MARK: - getRandomNumberTrivia
  
  var getRandomNumberTriviaNumberResponseCallsCount = 0
  var getRandomNumberTriviaNumberResponseCalled: Bool {
    getRandomNumberTriviaNumberResponseCallsCount > 0
  }
  var getRandomNumberTriviaNumberResponseReceivedArguments: (number: Int, response: NumberTriviaResponse)?
  var getRandomNumberTriviaNumberResponseReceivedInvocations: [(number: Int, response: NumberTriviaResponse)] = []
  var getRandomNumberTriviaNumberResponseClosure: ((Int, @escaping NumberTriviaResponse) -> Void)?
  
  func getRandomNumberTrivia(number: Int, response: @escaping NumberTriviaResponse) {
    getRandomNumberTriviaNumberResponseCallsCount += 1
    getRandomNumberTriviaNumberResponseReceivedArguments = (number: number, response: response)
    getRandomNumberTriviaNumberResponseReceivedInvocations.append((number: number, response: response))
    getRandomNumberTriviaNumberResponseClosure?(number, response)
  }
}
