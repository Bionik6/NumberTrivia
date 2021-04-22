//
//  FixtureLoader.swift
//  NumberTriviaTests
//
//  Created by Ibrahima Ciss on 22/04/2021.
//

import Foundation

class JSONLoader {
  
  static func loadJsonData<T: Decodable>(for request: String, fileExtension: String = "json") -> T {
    let bundle = Bundle(for: JSONLoader.self)
    let file = bundle.url(forResource: request, withExtension: fileExtension)
    let data = try! Data(contentsOf: file!)
    return try! JSONDecoder().decode(T.self, from: data)
  }
  
}
