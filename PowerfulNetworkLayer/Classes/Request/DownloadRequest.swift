//
//  DownloadRequest.swift
//  Requestable
//
//  Created by Andrew Kochulab on 4/7/18.
//  Copyright © 2018. All rights reserved.
//

import Foundation
import Alamofire

open class DownloadRequest: BaseRequest<Alamofire.DownloadRequest> {
    
    // MARK: - Types definition
    
    /// Progress changed
    public typealias ProgressChangedCallback = (Float) -> Void
    
    
    // MARK: - Callbacks
    
    /// Progress changed callback
    open var onProgressChanged: ProgressChangedCallback?
    
    
    // MARK: - Properties
    
    /// Source file url
    open var sourceURL: URL
    
    /// Destination file url (file, where we store data from sourceURL).
    open var destinationURL: URL?
    
    /// Path of resource
    override open var path: String {
        return sourceURL.absoluteString
    }
    
    /// Method (post, get, etc.)
    override open var method: HTTPMethod {
        return .get
    }
    
    
    // MARK: - Initialization
    
    /// Init request with parameters
    ///
    /// - Parameters:
    ///   - sourceURL: resource url
    ///   - destinationURL: destination url
    ///   - isExternalURL: is request path inherits from environment host
    public init(
        sourceURL: URL,
        destinationURL: URL? = nil,
        isExternalURL: Bool = true
    ) {
        self.sourceURL = sourceURL
        self.destinationURL = destinationURL
        
        super.init()
        
        self.isExternalURL = isExternalURL
    }
}
