//
//  LoginOperation.swift
//  PowerfulNetworkLayer_Example
//
//  Created by Andrew Kochulab on 4/9/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Foundation
import PromiseKit
import PowerfulNetworkLayer

final class LoginOperation: DispatchOperation<LoginRequest, LoginResponse> {
    override func execute<ServiceType>(
        in dispatcher: Dispatcher,
        by service: ServiceType
    ) -> Promise<LoginResponse>
        where ServiceType : AuthService {
            return super.execute(in: dispatcher, by: service).tap { result in
                switch result {
                    case .fulfilled(let response):
                        service.userIdentifier = response.userIdentifier
                    
                    case .rejected(_):
                        break
                }
            }
    }
}
