//
//  Environment.swift
//  Requestable
//
//  Created by Andrew Kochulab on 4/6/18.
//  Copyright © 2018. All rights reserved.
//

import Foundation
import Alamofire

public protocol Environment {
    
    /// Name of the environment
    var name: String { get }
    
    /// Base URL path of the environment
    var host: String { get }
    
    /// List of headers, which available in all requests
    var headers: HTTPHeaders { get }
    
    /// Cache policy of the environment
    var cachePolicy: URLRequest.CachePolicy { get }
}
