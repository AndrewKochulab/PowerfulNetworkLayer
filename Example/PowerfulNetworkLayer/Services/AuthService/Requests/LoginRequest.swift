//
//  LoginRequest.swift
//  PowerfulNetworkLayer_Example
//
//  Created by Andrew Kochulab on 4/9/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Foundation
import Alamofire
import PowerfulNetworkLayer

final class LoginRequest: BaseRequest<DataRequest> {
    private let email: String
    private let password: String
    
    override var path: String {
        return "auth/login"
    }
    
    override var method: HTTPMethod {
        return .post
    }
    
    override var encoding: ParameterEncoding {
        return JSONEncoding()
    }
    
    override var parameters: Parameters {
        return [
            "email" : email,
            "password" : password
        ]
    }
    
    init(email: String, password: String) {
        self.email = email
        self.password = password
    }
}
