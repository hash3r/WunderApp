//
//  WunderAppTests.swift
//  WunderAppTests
//
//  Created by Volodymyr Gnatiuk on 05.10.18.
//  Copyright © 2018 WunderApp. All rights reserved.
//

import Quick
import Nimble
@testable import WunderApp

let timeout: TimeInterval = 2

class CarViewControllerSpec: QuickSpec {
    override func spec() {
        describe("car view controller") {
            var controller: CarsViewController!
            
            beforeEach {
                controller = (UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CarsViewController") as! CarsViewController)
            }
            
            describe("handles errors") {
                context("when fetched data is empty") {
                    it("it's showing nothing") {
                        controller.viewModel = MockCarsViewModel(target: MockCarsTarget.emptyLocations)
                        _ = controller.view
                        expect(controller.errorLabel.text).toEventually(equal(NetworkError.noData.description()), timeout: timeout)
                        expect(controller.tableView.isHidden).toEventually(equal(true), timeout: timeout)
                        expect(controller.mapView.isHidden).toEventually(equal(true), timeout: timeout)
                    }
                }
                context("when fetched data is valid partially") {
                    beforeEach {
                        controller.viewModel = MockCarsViewModel(target: MockCarsTarget.partialLocations)
                        _ = controller.view
                    }
                    
                    it("map is showing only valid points") {
                        expect(controller.mapView.isHidden).toEventually(equal(false), timeout: timeout)
                        expect(controller.mapView.annotations.count).toEventually(equal(3), timeout: timeout) //only 3 valid points
                    }
                    
                    it("table is showing all possible cars") {
                        expect(controller.tableView.isHidden).toEventually(equal(false), timeout: timeout)
                        expect(controller.viewModel.cars.count).toEventually(equal(6), timeout: timeout)
                    }
                }
            }
        
            context("when select a point on the map") {
                it("it's hiding other points") {
                    controller.viewModel = MockCarsViewModel(target: MockCarsTarget.validLocations)
                    _ = controller.view
                    
                    expect(controller.mapView.annotations).toEventuallyNot(beEmpty(), timeout: timeout)
                    
                    //select annotation
                    let view = controller.mapView.view(for: controller.mapView.annotations.first!)!
                    controller.mapView(controller.mapView, didSelect: view)
                    expect(controller.errorLabel.text).toEventually(equal(NetworkError.noData.description()), timeout: timeout)
                    expect(controller.mapView.annotations.count).toEventually(equal(1), timeout: timeout)
                    
                    //deselect annotation
                    controller.mapView(controller.mapView, didDeselect: view)
                    expect(controller.mapView.annotations.count).toEventually(equal(controller.viewModel.annotations.count), timeout: timeout)
                    
                }
            }
        }
    }
}
