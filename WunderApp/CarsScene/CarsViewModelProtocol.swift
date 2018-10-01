//
//  CarsViewModelProtocol.swift
//  WunderApp
//
//  Created by Vladimir Gnatiuk on 10/1/18.
//  Copyright © 2018 WunderApp. All rights reserved.
//

import Foundation
import PromiseKit

protocol CarsViewModelProtocol {
    
    /// Data source
    var cars: [CarModel] { get }
    var annotations: [CarAnnotation] { get }
    var selectedAnnotation: CarAnnotation? { get set }
    
    /// Method asks for the next chunk of data
    ///
    /// - Returns: promise with a suggestion to update UI
    func loadData() -> Promise<Bool>
}
