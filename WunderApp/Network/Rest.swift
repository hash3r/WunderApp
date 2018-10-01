//
//  Rest.swift
//  WunderApp
//
//  Created by Vladimir Gnatiuk on 10/1/18.
//  Copyright © 2018 WunderApp. All rights reserved.
//

import Alamofire
import AlamofireObjectMapper
import ObjectMapper
import SwiftyJSON
import HTTPStatusCodes
import PromiseKit


/// REST singleton class for communication with the services
open class Rest {
    
    /// A shared instance of `Rest` is used by top-level request methods
    static let shared = Rest()
    
    /// Alamofire manager  that responsible for creating and managing `Request` objects
    fileprivate let manager = SessionManager()
    
    /// Method requests for data and serializes it to an array of given model type
    ///
    /// - Parameter target: endpoint to get data
    /// - Returns: promise with an array of given model type
    func arrayMappableRequest<T: BaseMappable>(_ target: TargetType, queue: DispatchQueue? = .global(), keyPath: String? = nil) -> Promise<[T]> {
        
        return Promise<[T]> { seal in
            let router = Router(target)
            let request = manager.request(router)
            request.responseArray(queue: queue, keyPath: keyPath) { (response: DataResponse<[T]>) -> Void in
//                debugPrint(response.fullDescription)
                if let value = response.result.value, response.isSuccess() {
                    seal.fulfill(value)
                } else {
                    if let error = response.result.error {
                        seal.reject(error)
                    } else {
                        seal.reject(self.defaultRestErrorWith(response.response?.statusCode))
                    }
                }
            }
        }
    }
    
    fileprivate func defaultRestErrorWith(_ code: Int?) -> NSError {
        return NSError(domain: Bundle.main.bundleIdentifier!, code: code ?? 0, userInfo: [NSLocalizedDescriptionKey: "See response above"])
    }
}
