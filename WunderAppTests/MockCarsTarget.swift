//
//  MockCarsTarget.swift
//  WunderAppTests
//
//  Created by Volodymyr Gnatiuk on 05.10.18.
//  Copyright © 2018 WunderApp. All rights reserved.
//

import Alamofire
import SwiftyJSON
@testable import WunderApp

enum MockCarsTarget {
    case emptyLocations
    case partialLocations
    case validLocations
}

extension MockCarsTarget: TargetType {

    func stubData() -> JSON? {
        var path = ""
        
        switch self {
        case .emptyLocations:
            path = "empty_locations"
        case .partialLocations:
            path = "partial_locations"
        case .validLocations:
            path = "valid_locations"
        }
        return JSON.jsonForPath(path, aClass: MockCarsViewModel.self)
    }
    
}
