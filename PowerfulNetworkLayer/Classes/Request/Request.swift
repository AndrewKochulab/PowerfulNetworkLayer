//
//  Request.swift
//  Requestable
//
//  Created by Andrew Kochulab on 4/6/18.
//  Copyright © 2018. All rights reserved.
//

import Foundation
import Alamofire

public protocol Request {
    
    /// Request Type
    associatedtype RequestType: Alamofire.Request
    
    /// Path of resource
    var path: String { get }
    
    /// Method (post, get, etc.)
    var method: HTTPMethod { get }
    
    /// Parameter encoding
    var encoding: ParameterEncoding { get }
    
    /// Headers
    var headers: HTTPHeaders { get }
    
    /// Body parameters
    var parameters: Parameters { get }
    
    /// URL request object
    var request: RequestType? { get set }
    
    /// Is current request cancelled
    var isCancelled: Bool { get }
    
    /// Is current request from external source
    var isExternalURL: Bool { get }
}
