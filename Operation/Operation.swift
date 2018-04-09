//
//  Operation.swift
//  Requestable
//
//  Created by Andrew Kochulab on 4/7/18.
//  Copyright © 2018. All rights reserved.
//

import Foundation
import PromiseKit

public protocol Operation {
    
    /// Type of request
    associatedtype Input: Request
    
    /// Type of response
    associatedtype Output: Response
    
    
    /// Request object
    var request: Input { get }
    
    
    /// Initialize operation with request
    ///
    /// - Parameter request: request object
    init(request: Input)
    
    
    /// Execute request in defined dispatcher
    ///
    /// - Parameter dispatcher: manager
    /// - Parameter service: service, which run the operation
    /// - Returns: promise
    func execute<ServiceType>(
        in dispatcher: Dispatcher,
        by service: ServiceType
    ) -> Promise<Output>
        where ServiceType: Servicable
}
