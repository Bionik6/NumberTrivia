//
//  NumberTriviaModel.swift
//  NumberTrivia
//
//  Created by Ibrahima Ciss on 23/04/2021.
//

import Foundation

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
