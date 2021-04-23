//
//  NumberTriviaModelTests.swift
//  NumberTriviaTests
//
//  Created by Ibrahima Ciss on 22/04/2021.
//

import XCTest
@testable import NumberTrivia

struct NumberTriviaModel: NumberTriviaProtocol, Codable {
  
  var number: Double
  var text: String
  
  func toJSON() -> String {
    let jsonEncoder = JSONEncoder()
    guard let data = try? jsonEncoder.encode(self),
          let string = String(data: data, encoding: .utf8)
    else { fatalError("Could not encode data") }
    return string
  }
  
}

class NumberTriviaModelTests: XCTestCase {
  
  private var sut: NumberTriviaModel!
  
  override func setUpWithError() throws {
    sut = NumberTriviaModel(number: 1.0, text: "hello")
  }
  
  override func tearDownWithError() throws {
    sut = nil
  }
  
  func test_sut_is_instance_of_NumberTrivia() {
    XCTAssertTrue((sut as Any) is NumberTriviaProtocol)
    XCTAssertTrue((sut as Any) is Codable)
  }
  
  func test_sut_can_be_decoded_to_NumberTriviaModel() {
    let object: NumberTriviaModel = JSONLoader.loadJsonData(for: "Trivia")
    XCTAssertEqual(object.number, 1.0)
    XCTAssertEqual(object.text, "1e+40 is the Eddington-Dirac number")
  }
  
  func test_sut_should_return_a_json_map_containing_the_proper_data() {
    let json = sut.toJSON()
    XCTAssertEqual(json, "{\"number\":1,\"text\":\"hello\"}")
  }
  
  
}
