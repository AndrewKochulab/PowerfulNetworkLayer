//
//  NetworkDispatcher.swift
//  Requestable
//
//  Created by Andrew Kochulab on 4/6/18.
//  Copyright © 2018. All rights reserved.
//

import Foundation
import ObjectMapper
import PromiseKit

open class NetworkDispatcher: BaseDispatcher {
    
    // MARK: - Request helpers
    
    /// Executes an request and provide a Promise with response
    ///
    /// - Parameter request: request to execute
    /// - Returns: promise
    /// - Throws: throw error if exists
    override public func execute<RequestType, ResponseType>(request: RequestType) throws -> Promise<ResponseType>
        where RequestType: BaseRequest<DataRequest>, ResponseType: Response, ResponseType: Mappable {
            let urlRequest = try preparedRequest(request)
            
            return Promise<ResponseType> { resolver in
                let formattedRequest = Alamofire.request(urlRequest)
                request.request = formattedRequest
                
                formattedRequest
                    .responseObject { (response: DataResponse<ResponseType>) in
                        self.handleResponse(response, resolver: resolver)
                }
            }
    }
}
