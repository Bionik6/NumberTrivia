//
//  InternetConnectionCheckerTests.swift
//  NumberTriviaTests
//
//  Created by Ibrahima Ciss on 25/04/2021.
//

import XCTest
import Network
@testable import NumberTrivia

protocol PathMonitor {
  var pathUpdateHandler: ((NWPath) -> Void)? { get set }
}
extension NWPathMonitor: PathMonitor { }


class NWConnectionChecker: NetworkInfo {
  
  private var monitor: PathMonitor
  
  init(monitor: PathMonitor) {
    self.monitor = monitor
  }
  
  func isConnected(_ connected: @escaping (Bool) -> ()) {
    monitor.pathUpdateHandler = { path in
      if path.status == .satisfied { connected(true) }
      connected(false)
    }
  }
  
}

class NWConnectionCheckerTests: XCTestCase {
  
  private var sut: NWConnectionChecker!
  private var path: PathMonitorMock!
  
  override func setUpWithError() throws {
    path = PathMonitorMock(status: .satisfied)
    sut = NWConnectionChecker(monitor: path)
  }
  
  override func tearDownWithError() throws {
    sut = nil
    path = nil
  }
  
  func test_sut_is_instance_of_NetworkInfo() {
    XCTAssertTrue((sut as Any) is NetworkInfo)
  }
  
  func test_is_should_forward_the_call_to_NWPathMonitor() {
    path.pathUpdateHandler = { path in
      XCTAssertEqual(path.status, .unsatisfied)
    }
  }
  
}

// MARK: - PathMonitorMock -

final class PathMonitorMock: PathMonitor {
  var pathUpdateHandler: ((NWPath) -> Void)?
  var status: NWPath.Status
  
  init(status: NWPath.Status) {
    self.status = status
    
  }
}
