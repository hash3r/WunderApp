//
//  CarsViewModel.swift
//  WunderApp
//
//  Created by Volodymyr Gnatiuk on 05.10.18.
//  Copyright © 2018 WunderApp. All rights reserved.
//

import Foundation
import PromiseKit

class CarsViewModel: CarsViewModelProtocol {
    
    private(set) var cars = [CarModel]()
    private(set) var annotations = [CarAnnotation]()
    private(set) var isLoading = false
    
    var selectedAnnotation: CarAnnotation?
    
    func loadData() -> Promise<Bool> {
        if self.isLoading {
            return Promise.value(false)
        }
        self.isLoading = true
        
        return Rest.shared.arrayMappableRequest(target(), keyPath: "placemarks")
            .map(on: DispatchQueue.global(), { (cars: [CarModel]) -> Bool in
            self.cars = cars
            self.annotations = self.cars
                .filter { $0.locationCoordinate() != nil }
                .map { CarAnnotation(model:$0) }
            return cars.count > 0
        }).ensure {
            self.isLoading = false
        }
    }
    
    internal func target() -> TargetType {
        return CarsTarget.allCars
    }
}
