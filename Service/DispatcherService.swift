//
//  DispatcherService.swift
//  Requestable
//
//  Created by Andrew Kochulab on 4/7/18.
//  Copyright © 2018. All rights reserved.
//

import Foundation
import PromiseKit

open class DispatcherService: DispatcherServicable {
    
    // MARK: - Properties

    /// Dispatcher dependency
    open let dispatcher: Dispatcher
    
    
    // MARK: - Initialization
    
    /// Initialization
    ///
    /// - Parameter dispatcher: external dependency
    required public init(dispatcher: Dispatcher) {
        self.dispatcher = dispatcher
    }
    
    
    // MARK: - Execution
    
    /// Execute operation
    ///
    /// - Parameter operation: operation
    /// - Returns: promise
    public func execute<OperationType>(operation: OperationType) -> Promise<OperationType.Output>
        where OperationType : Operation {
            return operation.execute(in: dispatcher, by: self)
    }
    
    
    /// Execute request
    ///
    /// - Parameters:
    ///   - request: provided request
    ///   - operation: operation, which will be execute an request
    /// - Returns: promise
    public func execute<RequestType, OperationType>(request: RequestType,
                                                    in operation: OperationType.Type)
        -> Promise<OperationType.Output>
        where RequestType == OperationType.Input, OperationType : Operation {
            return operation.init(request: request).execute(in: dispatcher, by: self)
    }
}
