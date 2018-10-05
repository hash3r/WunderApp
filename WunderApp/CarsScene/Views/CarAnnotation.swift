//
//  CarAnnotation.swift
//  WunderApp
//
//  Created by Volodymyr Gnatiuk on 05.10.18.
//  Copyright © 2018 WunderApp. All rights reserved.
//

import MapKit

class CarAnnotation: MKPointAnnotation {
    static let Key = "CarAnnotation"
    
    private var model: CarModel
    
    public init(model: CarModel) {
        self.model = model
        
        super.init()
        self.coordinate = model.locationCoordinate() ?? kCLLocationCoordinate2DInvalid
        self.title = model.name ?? ""
        self.subtitle = model.descriptionText()
    }
}
