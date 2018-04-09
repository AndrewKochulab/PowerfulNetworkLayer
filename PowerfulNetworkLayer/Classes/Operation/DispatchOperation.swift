//
//  DispatchOperation.swift
//  Requestable
//
//  Created by Andrew Kochulab on 4/7/18.
//  Copyright © 2018. All rights reserved.
//

import Foundation
import PromiseKit

open class DispatchOperation<InputType: Request, OutputType: Response>: Operation {
    
    // MARK: - Properties
    
    /// Request object
    open let request: InputType
    
    
    // MARK: - Initialization
    
    /// Initialize operation with request
    ///
    /// - Parameter request: request object
    required public init(request: InputType) {
        self.request = request
    }
    
    
    // MARK: - Execution
    
    /// Execute request in defined dispatcher
    ///
    /// - Parameter dispatcher: manager
    /// - Parameter service: service, which run the operation
    /// - Returns: promise
    open func execute<ServiceType>(
        in dispatcher: Dispatcher,
        by service: ServiceType
    ) -> Promise<OutputType>
        where ServiceType : Servicable {
            do {
                let promise: Promise<OutputType> = try dispatcher.execute(request: request)
                
                return promise
            } catch let error {
                return Promise<OutputType>(error: error)
            }
    }
}
