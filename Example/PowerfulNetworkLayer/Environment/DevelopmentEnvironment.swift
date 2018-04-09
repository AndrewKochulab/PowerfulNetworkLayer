//
//  DevelopmentEnvironment.swift
//  PowerfulNetworkLayer_Example
//
//  Created by Andrew Kochulab on 4/9/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Foundation
import Alamofire
import PowerfulNetworkLayer

struct DevelopmentEnvironment: Environment {
    var name: String {
        return "Development"
    }
    
    var host: String {
        return "http://development.com/v1"
    }
    
    var headers: HTTPHeaders {
        return [:]
    }
    
    var cachePolicy: URLRequest.CachePolicy {
        return .reloadIgnoringLocalAndRemoteCacheData
    }
}
