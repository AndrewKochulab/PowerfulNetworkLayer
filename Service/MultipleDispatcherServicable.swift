//
//  MultipleDispatcherServicable.swift
//  Requestable
//
//  Created by Andrew Kochulab on 4/7/18.
//  Copyright © 2018. All rights reserved.
//

import Foundation
import PromiseKit

public protocol MultipleDispatcherServicable: Servicable {
    
    /// Dispatchers
    var dispatchers: [Dispatcher] { get }
    
    
    /// Initialization
    ///
    /// - Parameter dispatchers: external dependencies
    init(dispatchers: [Dispatcher])
    
    
    /// Execute operation in dispatcher
    ///
    /// - Parameters:
    ///   - operation: available operation model
    ///   - dispatcherType: dispatcher type
    /// - Returns: promise
    func execute<OperationType, DispatcherType>(
        operation: OperationType,
        by dispatcherType: DispatcherType.Type
    ) -> Promise<OperationType.Output>
        where OperationType: Operation
    
    
    /// Execute a request
    ///
    /// - Parameters:
    ///   - request: request model
    ///   - operation: operation, which will be execute an request
    ///   - dispatcherType: dispatcher type
    /// - Returns: promise
    func execute<RequestType, OperationType, DispatcherType>(
        request: RequestType,
        in operation: OperationType.Type,
        by dispatcherType: DispatcherType.Type
    ) -> Promise<OperationType.Output>
        where OperationType: Operation, RequestType == OperationType.Input
}
