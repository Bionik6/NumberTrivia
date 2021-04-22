//
//  NumberTrivia.swift
//  NumberTrivia
//
//  Created by Ibrahima Ciss on 21/04/2021.
//

import Foundation

protocol NumberTriviaProtocol {
  var number: Int { get }
  var text: String { get }
}

struct NumberTrivia: NumberTriviaProtocol, Equatable {
  
  private(set) var number: Int
  private(set) var text: String

  init(number: Int, text: String) {
    self.number = number
    self.text = text
  }
  
}
