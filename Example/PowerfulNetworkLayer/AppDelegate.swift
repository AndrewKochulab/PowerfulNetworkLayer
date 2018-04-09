//
//  AppDelegate.swift
//  PowerfulNetworkLayer
//
//  Created by AndrewKochulab on 04/09/2018.
//  Copyright (c) 2018 AndrewKochulab. All rights reserved.
//

import UIKit
import PowerfulNetworkLayer

@UIApplicationMain
final class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Initialize environment
        let environment: Environment = DevelopmentEnvironment()
        
        ///////////////////////////////////
        
        // Create network dispatcher
        let networkDispatcher: Dispatcher = NetworkDispatcher(environment: environment)
        
        // Create auth service and login request
        let authService = AuthService(dispatcher: networkDispatcher)
        let loginRequest = LoginRequest(email: "test@gmail.com", password: "123123123")
        
        authService
            .execute(request: loginRequest, in: LoginOperation.self)
            .done { response in
                print(response.userIdentifier)
            }
            .catch { error in
                print(error.localizedDescription)
            }
        
        ///////////////////////////////////
        
        // Create download dispatcher
        let downloadDispatcher: Dispatcher = DownloadDispatcher(environment: environment)
        
        // Create download service and download request
        let downloadService = DownloadService(dispatcher: downloadDispatcher)
        let downloadRequest = DownloadRequest(sourceURL: URL(string: "https://www.colorado.edu/conflict/peace/download/peace.zip")!)
        
        downloadRequest.onProgressChanged = { progress in
            print(progress)
        }
        
        let downloadOperation = DownloadOperation(request: downloadRequest)
        downloadService
            .execute(operation: downloadOperation)
            .done { response in
                print(response.fileURL)
            }
            .catch { error in
                print(error.localizedDescription)
            }
        
        
        ///////////////////////////////////
        
        // Create service which using multiple dispatchers
        let service = PowerfulService(dispatchers: [
            networkDispatcher,
            downloadDispatcher
        ])
        
        service
            .execute(request: loginRequest, in: LoginOperation.self, by: NetworkDispatcher.self)
            .done { response in
                print(response.userIdentifier)
            }
            .catch { error in
                print(error.localizedDescription)
            }
        
        service
            .execute(operation: downloadOperation, by: DownloadDispatcher.self)
            .done { response in
                print(response.fileURL)
            }
            .catch { error in
                print(error.localizedDescription)
            }
        
        
        return true
    }
}
