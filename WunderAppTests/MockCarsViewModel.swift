//
//  MockCarsViewModel.swift
//  WunderAppTests
//
//  Created by Volodymyr Gnatiuk on 05.10.18.
//  Copyright © 2018 WunderApp. All rights reserved.
//

import Foundation
@testable import WunderApp

class MockCarsViewModel: CarsViewModel {
    
    private var mockTarget: TargetType
    
    init(target: TargetType) {
        mockTarget = target
    }
    
    override func target() -> TargetType {
        return mockTarget
    }
}
