//
//  NumberTrivia.swift
//  NumberTrivia
//
//  Created by Ibrahima Ciss on 21/04/2021.
//

import Foundation

struct NumberTrivia: Equatable {
  
  private let number: Int
  private let text: String

  init(number: Int, text: String) {
    self.number = number
    self.text = text
  }
  
}
