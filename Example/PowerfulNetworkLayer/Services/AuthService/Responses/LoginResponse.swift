//
//  LoginResponse.swift
//  PowerfulNetworkLayer_Example
//
//  Created by Andrew Kochulab on 4/9/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Foundation
import ObjectMapper
import PowerfulNetworkLayer

final class LoginResponse: Response, Mappable {
    let userIdentifier: String

    required init?(map: Map) {
        userIdentifier = "test"
    }
    
    func mapping(map: Map) {
        
    }
}
