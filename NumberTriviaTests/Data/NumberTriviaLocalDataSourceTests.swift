//
//  NumberTriviaLocalDataSourceTests.swift
//  NumberTriviaTests
//
//  Created by Ibrahima Ciss on 25/04/2021.
//

import XCTest
@testable import NumberTrivia

class NumberTriviaLocalDataSourceTests: XCTestCase {
  
  private var sut: UserDefaultsLocalDataSource!
  private var userDefaults: UserDefaults!
  
  override func setUpWithError() throws {
    userDefaults = UserDefaults(suiteName: #file)
    userDefaults.removePersistentDomain(forName: #file)
    sut = UserDefaultsLocalDataSource(userDefaults: UserDefaults.standard)
  }
  
  override func tearDownWithError() throws {
    sut = nil
    UserDefaults.standard.removeObject(forKey: UserDefaultsLocalDataSource.key)
  }
  
  func test_sut_send_a_failure_when_no_data_cached() {
    let promise = XCTestExpectation(description: #function)
    
    sut.getLastNumberTrivia { response in
      if case .failure(let error) = response {
        XCTAssertEqual(error, .noDataPresent)
      }
      promise.fulfill()
    }
    
    wait(for: [promise], timeout: 1.0)
  }
  
  func test_sut_can_cache_data() {
    let firstPromise = XCTestExpectation(description: "firstPromise")
    let secondPromise = XCTestExpectation(description: "secondPromise")
    let model: NumberTriviaModel = JSONLoader.loadJsonData(for: "Trivia")

    sut.cache(numberTrivia: model) {
      firstPromise.fulfill()
    }
    
    sut.getLastNumberTrivia { response in
      secondPromise.fulfill()
      let responseModel = try? response.get()
      XCTAssertNotNil(responseModel)
      XCTAssertEqual(model.text, responseModel?.text)
    }
    
    wait(for: [firstPromise, secondPromise], timeout: 1.0)
  }
  
}
