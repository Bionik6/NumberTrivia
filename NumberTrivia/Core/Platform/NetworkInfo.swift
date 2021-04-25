//
//  NetworkInfo.swift
//  NumberTrivia
//
//  Created by Ibrahima Ciss on 23/04/2021.
//

import Foundation

protocol NetworkInfo {
  func isConnected(_ connected: @escaping (Bool) -> ())
}
