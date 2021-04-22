//
//  UseCase.swift
//  NumberTrivia
//
//  Created by Ibrahima Ciss on 22/04/2021.
//

import Foundation

typealias NumberTriviaResponse = (Result<NumberTrivia, NumberTriviaError>) -> Void

struct NoParam { }

protocol UseCase {
  
  associatedtype T
  associatedtype Params
  
  func callAsFunction(params: Params, completion: @escaping NumberTriviaResponse)
  
}
