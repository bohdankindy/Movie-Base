//
//  Movie Info.swift
//  Movie Base Test task
//
//  Created by Bohdan Kindy on 10.05.2021.
//

import Foundation

enum ObjectSavableError: String, LocalizedError {
    case unableToEncode = "Unable to encode object into data"
    case unableToDecode = "Unable to decode object into given type"
    
    var errorDescription: String? {
        rawValue
    }
}
