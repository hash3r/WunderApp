//
//  CarsTarget.swift
//  WunderApp
//
//  Created by Vladimir Gnatiuk on 10/1/18.
//  Copyright © 2018 WunderApp. All rights reserved.
//

import Alamofire

enum CarsTarget {
    case allCars
}

extension CarsTarget: TargetType {
    
    func path() -> PathType {
        switch self {
        case .allCars: return "/wunderbucket/locations.json"
        }
    }
}
