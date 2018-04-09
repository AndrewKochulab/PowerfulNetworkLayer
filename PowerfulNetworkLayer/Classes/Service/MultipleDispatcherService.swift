//
//  MultipleDispatcherService.swift
//  Requestable
//
//  Created by Andrew Kochulab on 4/8/18.
//  Copyright © 2018. All rights reserved.
//

import Foundation
import PromiseKit

open class MultipleDispatcherService: MultipleDispatcherServicable {
    
    // MARK: - Properties
    
    /// Dispatchers
    open lazy var dispatchers = [Dispatcher]()
    
    
    // MARK: - Initialization
    
    /// Initialization
    ///
    /// - Parameter dispatchers: external dependencies
    public required init(dispatchers: [Dispatcher]) {
        self.dispatchers = dispatchers
    }
    
    
    // MARK: - Execution
    
    /// Execute operation in dispatcher
    ///
    /// - Parameters:
    ///   - operation: available operation model
    ///   - dispatcherType: dispatcher type
    /// - Returns: promise
    public func execute<OperationType, DispatcherType>(
        operation: OperationType,
        by dispatcherType: DispatcherType.Type
    ) -> Promise<OperationType.Output>
        where OperationType : Operation {
            guard let dispatcher = dispatchers.first(where: { $0 is DispatcherType }) else {
                return Promise<OperationType.Output>(error: NetworkError.unknownDispatcher)
            }
            
            return operation.execute(in: dispatcher, by: self)
    }
    
    
    /// Execute a request
    ///
    /// - Parameters:
    ///   - request: request model
    ///   - operation: operation, which will be execute an request
    ///   - dispatcherType: dispatcher type
    /// - Returns: promise
    public func execute<RequestType, OperationType, DispatcherType>(
        request: RequestType,
        in operation: OperationType.Type,
        by dispatcherType: DispatcherType.Type
    ) -> Promise<OperationType.Output>
        where RequestType == OperationType.Input, OperationType : Operation {
            let operation = operation.init(request: request)

            return self.execute(operation: operation, by: dispatcherType)
    }
}
