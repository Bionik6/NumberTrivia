//
//  InternetConnectionCheckerTests.swift
//  NumberTriviaTests
//
//  Created by Ibrahima Ciss on 25/04/2021.
//

import XCTest
import Network
@testable import NumberTrivia

struct InternetConnectionChecker: NetworkInfo {
  
  private let monitor: NWPathMonitor
  
  init(monitor: NWPathMonitor) {
    self.monitor = monitor
  }
  
  func isConnected(_ connected: @escaping (Bool) -> ()) {
    monitor.pathUpdateHandler = { path in
      if path.status == .satisfied { connected(true) }
      connected(false)
    }
  }
  
}

class InternetConnectionCheckerTests: XCTestCase {
  
  private var networkInfo: NetworkInfoMock!
  private var sut: InternetConnectionChecker!
  
  override func setUpWithError() throws {
    sut = InternetConnectionChecker(monitor: NWPathMonitor())
  }
  
  override func tearDownWithError() throws {
    sut = nil
  }

  func test_sut_is_instance_of_NetworkInfo() {
    XCTAssertTrue((sut as Any) is NetworkInfo)
  }
  
}
