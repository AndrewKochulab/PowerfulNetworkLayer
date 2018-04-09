//
//  BaseRequest.swift
//  Requestable
//
//  Created by Andrew Kochulab on 4/7/18.
//  Copyright © 2018. All rights reserved.
//

import Foundation
import Alamofire

open class BaseRequest<RequestType: Alamofire.Request>: Request {
    
    // MARK: - Properties
    
    /// Path of resource
    open var path: String {
        return ""
    }
    
    /// Method (post, get, etc.)
    open var method: HTTPMethod {
        return .get
    }
    
    /// Parameter encoding
    open var encoding: ParameterEncoding {
        return JSONEncoding()
    }
    
    /// Headers
    open var headers: HTTPHeaders {
        return [:]
    }
    
    /// Body parameters
    open var parameters: Parameters {
        return [:]
    }

    /// URL request object
    open var request: RequestType?
    
    /// Is current request cancelled
    open var isCancelled: Bool = false {
        willSet {
            if !self.isCancelled {
                request?.cancel()
            }
        }
    }
    
    /// Is current request from external source
    open var isExternalURL: Bool = false
    
    
    /// Initialization
    public init() { }
}
