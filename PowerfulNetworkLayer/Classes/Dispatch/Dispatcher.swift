//
//  Dispatcher.swift
//  Requestable
//
//  Created by Andrew Kochulab on 4/6/18.
//  Copyright © 2018. All rights reserved.
//

import Foundation
import Alamofire
import PromiseKit

public protocol Dispatcher {
    
    /// Configure dispatcher with environment
    ///
    /// - Parameter environment: initialized environment
    init(environment: Environment)
    
    
    /// Executes an request and provide a Promise with response
    ///
    /// - Parameter request: request to execute
    /// - Returns: promise
    /// - Throws: throw error if exists
    func execute<RequestType, ResponseType>(request: RequestType) throws -> Promise<ResponseType>
        where RequestType: Request, ResponseType: Response
    
    
    /// Form URLRequest by request object
    ///
    /// - Parameter request: request object
    /// - Returns: formatted url request
    /// - Throws: throw error if exists
    func urlRequest<RequestType>(from request: RequestType) throws -> URLRequest
        where RequestType: Request
}
