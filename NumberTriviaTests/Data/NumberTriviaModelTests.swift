//
//  NumberTriviaModelTests.swift
//  NumberTriviaTests
//
//  Created by Ibrahima Ciss on 22/04/2021.
//

import XCTest
@testable import NumberTrivia

struct NumberTriviaModel: NumberTriviaProtocol, Decodable {
  var number: Int
  var text: String
}

class NumberTriviaModelTests: XCTestCase {
  
  private var sut: NumberTriviaModel!
  
  override func setUpWithError() throws {
    sut = NumberTriviaModel(number: 1, text: "hello")
  }
  
  override func tearDownWithError() throws {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
  }
  
  func test_sut_is_instance_of_NumberTrivia() {
    XCTAssertTrue((sut as Any) is NumberTriviaProtocol)
    XCTAssertTrue((sut as Any) is Decodable)
  }
  
  
}
