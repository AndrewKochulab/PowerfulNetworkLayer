//
//  AuthService.swift
//  PowerfulNetworkLayer_Example
//
//  Created by Andrew Kochulab on 4/9/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Foundation
import PowerfulNetworkLayer

final class AuthService: DispatcherService {
    var userIdentifier: String?
    
    var isUserLoggedIn: Bool {
        return userIdentifier != nil
    }
}
