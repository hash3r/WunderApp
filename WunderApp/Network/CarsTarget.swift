//
//  CarsTarget.swift
//  WunderApp
//
//  Created by Volodymyr Gnatiuk on 05.10.18.
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
