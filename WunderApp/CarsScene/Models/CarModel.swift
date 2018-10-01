//
//  CarModel.swift
//  WunderApp
//
//  Created by Vladimir Gnatiuk on 10/1/18.
//  Copyright © 2018 WunderApp. All rights reserved.
//

import ObjectMapper
import CoreLocation
import MapKit

enum CarStatusType: String {
    case good = "GOOD"
    case unacceptable = "UNACCEPTABLE"
}

struct CarModel: Mappable {
    
    var vin: String?
    var address: String?
    var name: String?
    var fuel: Int?
    var engineType: String?
    var exterior: CarStatusType?
    var interior: CarStatusType?
    private var coordinates: [Double]?
    
    init?(map: Map) {
    }

    mutating func mapping(map: Map) {
        vin <- map["vin"]
        address <- map["address"]
        name <- map["name"]
        fuel <- map["fuel"]
        exterior <- map["exterior"]
        interior <- map["interior"]
        engineType <- map["engineType"]
        coordinates <- map["coordinates"]
    }
    
    func locationCoordinate() -> CLLocationCoordinate2D? {
        if let coords = coordinates, coords.count >= 2  {
            return CLLocationCoordinate2D(latitude: coords[1], longitude: coords[0])
        }
        return nil
    }
    
    func descriptionText() -> String {
        var text = ""
//        if let trans = transmission {
//            let type = TransmissionType(type: trans)
//            text += "Transmission: " + type.rawValue
//        }
//        if let fuel = fuelType {
//            let type = FuelType(type: fuel)
//            text += (text.characters.count > 0 ? ". " : "") + "Fuel type: " + type.rawValue
//        }
        return text
    }
    
}
