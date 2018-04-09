//
//  NetworkError.swift
//  Requestable
//
//  Created by Andrew Kochulab on 4/6/18.
//  Copyright © 2018. All rights reserved.
//

import Foundation

public enum NetworkError: Error {
    case badInput
    case wrongHostURL
    case unknownDispatcher
}
