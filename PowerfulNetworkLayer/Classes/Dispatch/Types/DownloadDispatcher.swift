//
//  DownloadDispatcher.swift
//  Requestable
//
//  Created by Andrew Kochulab on 4/7/18.
//  Copyright © 2018. All rights reserved.
//

import Foundation
import Alamofire
import PromiseKit

open class DownloadDispatcher: BaseDispatcher {
    
    // MARK: - Properties
    
    /// Background Network Key
    open let storageKey = "Requestable.downloadNetworkDispatcher"
    
    /// Requests container
    private var requests = [DownloadRequest]()

    
    // MARK: - Configuration
    
    /// Manager configuration
    ///
    /// - Returns: Alamofire Session Manager
    override public func configuratedManager() -> SessionManager {
        let configuration = URLSessionConfiguration.background(withIdentifier: storageKey)
        configuration.requestCachePolicy = environment.cachePolicy
        configuration.httpAdditionalHeaders = SessionManager.defaultHTTPHeaders
        
        return SessionManager(configuration: configuration)
    }
    
    
    // MARK: - Request helpers
    
    /// Executes an request and provide a Promise with response
    ///
    /// - Parameter request: request to execute
    /// - Returns: promise
    /// - Throws: throw error if exists
    override public func execute<RequestType, ResponseType>(request: RequestType) throws -> Promise<ResponseType>
        where RequestType: DownloadRequest, ResponseType: DownloadResponse {
            let urlRequest = try preparedRequest(request)
            
            return Promise<ResponseType> { resolver in
                request.request = Alamofire.download(
                    urlRequest,
                    to: { (url, urlResponse) -> (destinationURL: URL, options: Alamofire.DownloadRequest.DownloadOptions) in
                        guard let destinationURL = request.destinationURL else {
                            let suggestedDestinationURL = Alamofire.DownloadRequest.suggestedDownloadDestination(for: .documentDirectory, in: .userDomainMask)
                            
                            return suggestedDestinationURL(url, urlResponse)
                        }
                        
                        return (destinationURL: destinationURL, options: .removePreviousFile)
                    })
                    .downloadProgress(queue: .global()) { progress in
                        let convertedProgress = Float(progress.fractionCompleted)
                        
                        DispatchQueue.main.async {
                            request.onProgressChanged?(convertedProgress)
                        }
                    }
                    .response { response in
                        self.deleteRequest(request)
                        
                        DispatchQueue.main.async {
                            guard let destinationURL = response.destinationURL,
                                response.error == nil else {
                                    resolver.reject(response.error!)
                                
                                    return
                            }
                            
                            let fileResponse = ResponseType.init(fileURL: destinationURL)
                            resolver.fulfill(fileResponse)
                        }
                    }
            }
    }
    
    /// Check if request with the same sourceURL exists
    ///
    /// - Parameter sourceURL: file url
    /// - Returns: download request
    public func requestExists(sourceURL: URL) -> DownloadRequest? {
        return requests.first(where: { $0.sourceURL == sourceURL })
    }
    
    /// Add request to container
    ///
    /// - Parameter request: download request
    /// - Returns: returns true if request doesn't already exists in the container
    @discardableResult
    public func addRequest(_ request: DownloadRequest) -> Bool {
        guard requestExists(sourceURL: request.sourceURL) == nil else {
            return false
        }
        
        requests.append(request)
        
        return true
    }
    
    /// Delete request from container
    ///
    /// - Parameter request: download request
    public func deleteRequest(_ request: DownloadRequest) {
        if let position = requests.index(where: { $0.sourceURL == request.sourceURL }) {
            requests.remove(at: position)
        }
    }
}
