//
//  DispatcherServicable.swift
//  Requestable
//
//  Created by Andrew Kochulab on 4/8/18.
//  Copyright © 2018. All rights reserved.
//

import Foundation
import PromiseKit

public protocol DispatcherServicable: Servicable {
    
    /// Dispatcher dependency
    var dispatcher: Dispatcher { get }
    
    
    /// Initialization
    ///
    /// - Parameter dispatcher: external dependency
    init(dispatcher: Dispatcher)
    
    
    /// Execute operation
    ///
    /// - Parameter operation: operation
    /// - Returns: promise
    func execute<OperationType>(operation: OperationType) -> Promise<OperationType.Output>
        where OperationType: Operation
    
    
    /// Execute request
    ///
    /// - Parameters:
    ///   - request: provided request
    ///   - operation: operation, which will be execute an request
    /// - Returns: promise
    func execute<RequestType, OperationType>(
        request: RequestType,
        in operation: OperationType.Type
    ) -> Promise<OperationType.Output>
        where OperationType: Operation, RequestType == OperationType.Input
}
