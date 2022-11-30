//
//  ViewController.swift
//  GoogleMapsTracker
//
//  Created by admin on 21.11.2022.
//

import UIKit
import GoogleMaps

class MapViewController: UIViewController {
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var increaseScaleButton: UIButton!
    @IBOutlet weak var decreaseScaleButton: UIButton!
    @IBOutlet weak var currentLocationButton: UIButton!
    
    @IBAction func decreaseScale(_ sender: Any) {
        scale -= 1
        let camera = GMSCameraPosition.camera(withTarget: mapView.camera.target, zoom: Float(scale))
        mapView.camera = camera
    }
    @IBAction func increaseScale(_ sender: UIButton) {
        scale += 1
        let camera = GMSCameraPosition.camera(withTarget: mapView.camera.target, zoom: Float(scale))
        mapView.camera = camera
    }
    @IBAction func goToCurrentLocation(_ sender: Any) {
        mapView.animate(toLocation: currentCoordinate)
    }
    
    var currentCoordinate = CLLocationCoordinate2D(
        latitude: 37.34033264974476,
        longitude: -122.06892632102273)
    var currentCameraCoordinate = CLLocationCoordinate2D(
        latitude: 37.34033264974476,
        longitude: -122.06892632102273)
    var scale = 15
//    let coordinate = CLLocationCoordinate2D(
//        latitude: 37.34033264974476,
//        longitude: -122.06892632102273)
    var locationManager: CLLocationManager?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureMap()
        configureLocationManager()
    }
    
    private func configureLocationManager() {
        
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.requestAlwaysAuthorization()
        locationManager?.startUpdatingLocation()
        //locationManager?.allowsBackgroundLocationUpdates = true
    }
    
    private func configureMap() {
        mapView.delegate = self
        let camera = GMSCameraPosition.camera(withTarget: currentCameraCoordinate, zoom: Float(scale))
        mapView.camera = camera
        mapView.isMyLocationEnabled = true
        increaseScaleButton.layer.cornerRadius = 25
        decreaseScaleButton.layer.cornerRadius = 25
        currentLocationButton.layer.cornerRadius = 25
    }
}

extension MapViewController: GMSMapViewDelegate {
    
}

extension MapViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        
        currentCoordinate = location.coordinate
        
        let marker = GMSMarker(position: location.coordinate)
        marker.map = mapView
        let camera = GMSCameraPosition.camera(withTarget: currentCoordinate, zoom: Float(scale))
        mapView.camera = camera
        print(location.coordinate)
    }
}
