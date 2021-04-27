//
//  NumberTriviaRemoteDataSourceTests.swift
//  NumberTriviaTests
//
//  Created by Ibrahima Ciss on 26/04/2021.
//

import XCTest
@testable import NumberTrivia

protocol HTTPClient {
  func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
}

extension URLSession: HTTPClient { }


class RemoteNumberTriviaDataSource: NumberTriviaRemoteDataSource {
  private(set) var client: HTTPClient
  
  init(client: HTTPClient = URLSession.shared) {
    self.client = client
  }
  
  func getRandomNumberTrivia(completion: @escaping NumberTriviaRemoteResult) {
    
  }
  
  func getConcreteNumberTrivia(number: Double, completion: @escaping NumberTriviaRemoteResult) {
    
  }
}


class NumberTriviaRemoteDataSourceTests: XCTestCase {
  
  private var sut: RemoteNumberTriviaDataSource!
  private var mock: HTTPClientMock!
  
  override func setUpWithError() throws {
    mock = HTTPClientMock()
    sut = RemoteNumberTriviaDataSource(client: mock)
  }
  
  override func tearDownWithError() throws {
    mock = nil
    sut = nil
  }
  
  func test_sut_is_instance_of_NumberTriviaRemoteDataSource() {
    XCTAssertTrue((sut as Any) is NumberTriviaRemoteDataSource)
  }
  
  func test_sut_should_perform_a_get_request_on_a_url_with_number_being_the_endpoint_and_with_application_json_header() {
    
  }
  
}

// MARK: - HTTPClientMock -

final class HTTPClientMock: HTTPClient {
  
  // MARK: - dataTask
  
  var dataTaskWithCompletionHandlerCallsCount = 0
  var dataTaskWithCompletionHandlerCalled: Bool {
    dataTaskWithCompletionHandlerCallsCount > 0
  }
  var dataTaskWithCompletionHandlerReceivedArguments: (request: URLRequest, completionHandler: (Data?, URLResponse?, Error?) -> Void)?
  var dataTaskWithCompletionHandlerReceivedInvocations: [(request: URLRequest, completionHandler: (Data?, URLResponse?, Error?) -> Void)] = []
  var dataTaskWithCompletionHandlerReturnValue: URLSessionDataTask!
  var dataTaskWithCompletionHandlerClosure: ((URLRequest, @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask)?
  
  func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
    dataTaskWithCompletionHandlerCallsCount += 1
    dataTaskWithCompletionHandlerReceivedArguments = (request: request, completionHandler: completionHandler)
    dataTaskWithCompletionHandlerReceivedInvocations.append((request: request, completionHandler: completionHandler))
    return dataTaskWithCompletionHandlerClosure.map({ $0(request, completionHandler) }) ?? dataTaskWithCompletionHandlerReturnValue
  }
}
