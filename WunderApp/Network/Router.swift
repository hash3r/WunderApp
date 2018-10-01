//
//  Router.swift
//  WunderApp
//
//  Created by Vladimir Gnatiuk on 10/1/18.
//  Copyright © 2018 WunderApp. All rights reserved.
//

import Alamofire
import SwiftyJSON

enum RoterError: Error {
    case invalidUrl
}

/// Router builds URLRequest from a target model
public struct Router {

    private let target: TargetType

    init(_ target: TargetType) {
        self.target = target
    }

    private func url() -> URL? {
        let fullUrl = target.baseUrl() + target.path()
        guard let encoded = fullUrl.encodeURLQuery() else { return nil }
        return URL(string: encoded)
    }
    
    private func headers() -> HTTPHeaders {
        return target.headers()
    }
}

// MARK: URLRequestConvertible
extension Router: URLRequestConvertible {

    public func asURLRequest() throws -> URLRequest {
        guard let url = url(),
            var request = try? URLRequest(url: url, method: target.method(), headers: headers())
            else { throw  RoterError.invalidUrl }
        
        request.httpMethod = target.method().rawValue
        if let params = target.params() {
            let data = try? JSON(params).rawData()
            request.httpBody = data
        }
        return request
    }
}
