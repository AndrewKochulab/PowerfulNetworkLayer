//
//  BaseDispatcher.swift
//  Requestable
//
//  Created by Andrew Kochulab on 4/7/18.
//  Copyright © 2018. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper
import PromiseKit
import AlamofireObjectMapper

open class BaseDispatcher: Dispatcher {
    
    // MARK: - Properties
    
    /// Environment
    open let environment: Environment
    
    /// Session Manager
    open var manager: SessionManager!
    
    
    // MARK: - Initialization
    
    /// Configure dispatcher with environment
    ///
    /// - Parameter environment: initialized environment
    required public init(environment: Environment) {
        self.environment = environment
        self.manager = configuratedManager()
    }
    
    
    // MARK: - Configuration
    
    /// Manager configuration
    ///
    /// - Returns: Session Manager
    public func configuratedManager() -> SessionManager {
        let configuration: URLSessionConfiguration = .default
        configuration.httpAdditionalHeaders = SessionManager.defaultHTTPHeaders
        configuration.requestCachePolicy = environment.cachePolicy
        
        return SessionManager(configuration: configuration)
    }
    
    
    // MARK: - Request helpers
    
    /// Executes an request and provide a Promise with response
    ///
    /// - Parameter request: request to execute
    /// - Returns: promise
    /// - Throws: throw error if exists
    public func execute<RequestType, ResponseType>(request: RequestType) throws -> Promise<ResponseType>
        where RequestType: Request, ResponseType: Response {
            fatalError("Please implement execute method")
    }
    
    /// Form URLRequest by request
    ///
    /// - Parameter request: request model
    /// - Returns: formatted url request
    /// - Throws: catch error if exists
    public func urlRequest<RequestType>(from request: RequestType) throws -> URLRequest
        where RequestType: Request {
            var url: URL!
            
            if request.isExternalURL {
                guard let externalURL = URL(string: request.path) else {
                    throw NetworkError.wrongHostURL
                }
                
                url = externalURL
            } else {
                guard let hostURL = URL(string: environment.host) else {
                    throw NetworkError.wrongHostURL
                }
                
                url = hostURL.appendingPathComponent(request.path)
            }
            
            var urlRequest = try URLRequest(url: url, method: request.method)
            
            urlRequest.allHTTPHeaderFields = self.environment.headers
                .merging(request.headers) { _, new -> String in new }
            
            return urlRequest
    }
    
    /// Request preparation
    ///
    /// - Parameter request: request object
    /// - Returns: formatted url request
    /// - Throws: throw error if exists
    public func preparedRequest<RequestType>(_ request: RequestType) throws -> URLRequest
        where RequestType: Request {
            return try self.urlRequest(from: request)
    }
    
    /// Response handler
    ///
    /// - Parameters:
    ///   - response: response object
    ///   - resolver: promise resolver
    public func handleResponse<ResponseType>(
        _ response: DataResponse<ResponseType>,
        resolver: Resolver<ResponseType>
        ) where ResponseType: Response {
        switch response.result {
            case .success(let responseObject):
                resolver.fulfill(responseObject)
            
            case .failure(let error):
                resolver.reject(error)
        }
    }
}
