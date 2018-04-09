//
//  DownloadResponse.swift
//  Requestable
//
//  Created by Andrew Kochulab on 4/7/18.
//  Copyright © 2018. All rights reserved.
//

import Foundation

open class DownloadResponse: Response {
    
    // MARK: - Properties
    
    /// Destination File URL
    open let fileURL: URL
    
    
    // MARK: - Initialization
    
    /// Initialize response with url
    ///
    /// - Parameter fileURL: destination file url
    required public init(fileURL: URL) {
        self.fileURL = fileURL
    }
}
