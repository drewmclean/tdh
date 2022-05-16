//
//  NumbersClientError.swift
//  Numbers
//
//  Created by Andrew McLean on 5/11/22.
//

import Foundation

enum NumbersClientError: Error, Equatable {
    case invalidURLString(String)
    case networkUnavailable
    case networkError(String)
    case invalidResponse(String)
}
