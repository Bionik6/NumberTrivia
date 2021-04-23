//
//  NumberTrivia.swift
//  NumberTrivia
//
//  Created by Ibrahima Ciss on 21/04/2021.
//

import Foundation

protocol NumberTriviaProtocol {
  var number: Double { get }
  var text: String { get }
}

struct NumberTrivia: NumberTriviaProtocol, Equatable {
  
  private(set) var number: Double
  private(set) var text: String

  init(number: Double, text: String) {
    self.number = number
    self.text = text
  }
  
}
