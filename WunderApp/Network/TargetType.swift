//
//  TargetType.swift
//  WunderApp
//
//  Created by Volodymyr Gnatiuk on 05.10.18.
//  Copyright © 2018 WunderApp. All rights reserved.
//

import Alamofire
import SwiftyJSON

public typealias PathType = String
public typealias ParametersType = Any

/// Protocol describes endpoints metadata
public protocol TargetType {
    
    func baseUrl() -> PathType
    func path() -> PathType
    func method() -> Alamofire.HTTPMethod
    func params() -> ParametersType?
    func headers() -> HTTPHeaders
    func stubData() -> JSON?
}

/// implement default behaviour
extension TargetType {
    
    func baseUrl() -> PathType {
        return Config.Server.BaseUrl + Config.Server.ApiVersion
    }
    
    func path() -> PathType {
        return ""
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
    
    func stubData() -> JSON? {
        return nil
    }
    
}

