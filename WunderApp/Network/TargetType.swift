//
//  TargetType.swift
//  WunderApp
//
//  Created by Vladimir Gnatiuk on 10/1/18.
//  Copyright © 2018 WunderApp. All rights reserved.
//

import Alamofire

public typealias PathType = String
public typealias ParametersType = Any

/// Protocol describes endpoints metadata
public protocol TargetType {
    
    func baseUrl() -> PathType
    func path() -> PathType
    func method() -> Alamofire.HTTPMethod
    func params() -> ParametersType?
    func headers() -> HTTPHeaders
}

/// implement default behaviour
extension TargetType {
    
    func baseUrl() -> PathType {
        return Config.Server.BaseUrl + Config.Server.ApiVersion
    }
    
    func params() -> ParametersType? {
        return nil
    }
    
    func headers() -> HTTPHeaders {
        return HTTPHeaders()
    }
    
    func method() -> Alamofire.HTTPMethod {
        return .get
    }
}
