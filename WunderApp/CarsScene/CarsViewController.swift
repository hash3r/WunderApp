//
//  CarsViewController.swift
//  WunderApp
//
//  Created by Volodymyr Gnatiuk on 05.10.18.
//  Copyright © 2018 WunderApp. All rights reserved.
//

import UIKit
import MapKit
import PromiseKit

enum ViewType: Int {
    case list
    case map
}

class CarsViewController: UIViewController {
    
    @IBOutlet internal weak var segmentControl: UISegmentedControl!
    @IBOutlet internal weak var tableView: UITableView!
    @IBOutlet internal weak var mapView: MKMapView!
    @IBOutlet internal weak var errorLabel: UILabel!
    
    var viewModel: CarsViewModelProtocol = CarsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        loadData()
    }
    
    internal func configureTableView() {
        tableView.tableFooterView = UIView()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100
    }
    
    internal func loadData() {
        viewModel.loadData().done { [weak self] updateUI in
            self?.updateUI()
        }.catch { [weak self] error in
            self?.updateUI(error)
        }
    }
    
    internal func updateUI(_ error: Error? = nil) {
        if let error = error as? NetworkError {
            errorLabel.isHidden = false
            errorLabel.text = error.description()
            tableView.isHidden = true
            mapView.removeAnnotations(mapView.annotations)
            mapView.isHidden = true
        } else {
            errorLabel.isHidden = true
            tableView.isHidden = false
            tableView.reloadData()
            reloadAnnotations()
        }
    }
    
    internal func reloadAnnotations() {
        if let selected = viewModel.selectedAnnotation {
            let remove = viewModel.annotations.filter { $0 != selected }
            mapView.removeAnnotations(remove)
        } else {
            mapView.removeAnnotations(mapView.annotations)
            mapView.addAnnotations(viewModel.annotations)
            mapView.showAnnotations(mapView.annotations, animated: true)
        }
    }
    
    @IBAction func changedViewType(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == ViewType.map.rawValue {
            tableView.isHidden = true
            mapView.isHidden = false
        } else if sender.selectedSegmentIndex == ViewType.list.rawValue {
            tableView.isHidden = false
            mapView.isHidden = true
        }
    }
}

extension CarsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.cars.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CarTableCell.Key, for: indexPath) as! CarTableCell
        let car = viewModel.cars[indexPath.row]
        cell.carModel = car
        return cell
    }
}

extension CarsViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: CarAnnotation.Key)
        
        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: CarAnnotation.Key)
            annotationView?.tintColor = UIColor.red
            annotationView?.canShowCallout = true
        } else {
            annotationView?.annotation = annotation
        }
        
//        let placeholder = UIImage(named: "car_template") ?? UIImage()
//        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 120, height: 80))
//        imageView.contentMode = .scaleAspectFit
//        imageView.image = placeholder
//        annotationView?.detailCalloutAccessoryView = imageView
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        viewModel.selectedAnnotation = view.annotation as? CarAnnotation
        reloadAnnotations()
    }
    
    func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
        viewModel.selectedAnnotation = nil
        reloadAnnotations()
    }
}

