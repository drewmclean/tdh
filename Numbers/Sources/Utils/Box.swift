//
//  Box.swift
//  InterviewProject
//
//  Created by Andrew McLean on 12/18/21.
//

import Foundation

/*
    This is a simple class for binding to value changes on a property. It's similar to KVO but there is no need to keep a reference to an observation and handle cleanup.
 */
final class Box<T> {
    
    typealias Listener = (T) -> Void
    
    var listener: Listener?
    
    var value: T {
        didSet {
            listener?(value)
        }
    }
    
    init(_ value: T) {
        self.value = value
    }
    
    func bind(listener: Listener?) {
        self.listener = listener
        listener?(value)
    }
    
}
