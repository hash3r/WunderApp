//
//  ResponseExt.swift
//  WunderApp
//
//  Created by Volodymyr Gnatiuk on 05.10.18.
//  Copyright © 2018 WunderApp. All rights reserved.
//

import Foundation
import HTTPStatusCodes
import Alamofire
import SwiftyJSON

extension DataResponse {
    
    func isSuccess() -> Bool {
        if let code = response?.statusCode, let statusCode = HTTPStatusCode(rawValue: code) {
//      handle different error codes. for example unauthorized request
            return statusCode.isSuccess
        }
        return false
    }

    /// The debug textual representation used when written to an output stream, which includes the URL request, the URL
    /// response, the server data and the response serialization result.
    public var fullDescription: String {
        var output: [String] = []
        output.append(request != nil ? "[Request]: \(request!)" : "[Request]: nil")
        output.append(response != nil ? "[Response]: \(response!)" : "[Response]: nil")
//        output.append("[Data]: \(data?.length ?? 0) bytes")
        output.append("[Result]: \(result.debugDescription)")
        output.append("[Timeline]: \(timeline.debugDescription)")
        if let data = data {
            let responseData = try? JSON(data: data)
            output.append("[Data]: \(responseData.debugDescription)")
        }
        return output.joined(separator: "\n")
    }
}
