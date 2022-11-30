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
    @IBOutlet weak var newTrackButton: UIButton!
    @IBOutlet weak var stopTrackButton: UIButton!
    @IBOutlet weak var loadPreviousTrackButton: UIButton!
    
    @IBAction func decreaseScale(_ sender: UIButton) {
        scale -= 1
        let camera = GMSCameraPosition.camera(withTarget: mapView.camera.target, zoom: Float(scale))
        mapView.camera = camera
    }
    @IBAction func increaseScale(_ sender: UIButton) {
        scale += 1
        let camera = GMSCameraPosition.camera(withTarget: mapView.camera.target, zoom: Float(scale))
        mapView.camera = camera
    }
    @IBAction func goToCurrentLocation(_ sender: UIButton) {
        mapView.animate(toLocation: currentCoordinate)
    }
    @IBAction func startNewTrack(_ sender: UIButton) {
        routePoints.removeAll()
        locationManager?.requestLocation()
        route?.map = nil
        route = GMSPolyline()
        routePath = GMSMutablePath()
        route?.map = mapView
        locationManager?.startUpdatingLocation()
    }
    @IBAction func stopTrack(_ sender: UIButton) {
    }
    @IBAction func loadPreviousTrack(_ sender: UIButton) {
    }
    
    var currentCoordinate = CLLocationCoordinate2D(
        latitude: 37.34033264974476,
        longitude: -122.06892632102273)
    var currentCameraCoordinate = CLLocationCoordinate2D(
        latitude: 37.34033264974476,
        longitude: -122.06892632102273)
    var scale = 15
    var locationManager: CLLocationManager?
    var backgroundTask: UIBackgroundTaskIdentifier?
    
    var route: GMSPolyline?
    var routePath: GMSMutablePath?
    var routePoints = [CLLocation]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureMap()
        configureLocationManager()
        configureBackground()
    }
    
    private func configureLocationManager() {
        
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.allowsBackgroundLocationUpdates = true
        locationManager?.startMonitoringSignificantLocationChanges()
        locationManager?.pausesLocationUpdatesAutomatically = false
        
        locationManager?.requestAlwaysAuthorization()
    }
    
    private func configureMap() {
        mapView.delegate = self
        let camera = GMSCameraPosition.camera(withTarget: currentCameraCoordinate, zoom: Float(scale))
        mapView.camera = camera
        mapView.isMyLocationEnabled = true
        
        increaseScaleButton.layer.cornerRadius = 25
        decreaseScaleButton.layer.cornerRadius = 25
        currentLocationButton.layer.cornerRadius = 25
        newTrackButton.layer.cornerRadius = 25
        stopTrackButton.layer.cornerRadius = 25
        loadPreviousTrackButton.layer.cornerRadius = 25
    }
    
    private func configureBackground() {
        backgroundTask = UIApplication.shared.beginBackgroundTask { [weak self] in
            guard let self = self,
                  let backgroundTask = self.backgroundTask else { return }
            
            UIApplication.shared.endBackgroundTask(backgroundTask)
            self.backgroundTask = .invalid
        }
    }
}

extension MapViewController: GMSMapViewDelegate {
    
}

extension MapViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        
        currentCoordinate = location.coordinate

        let camera = GMSCameraPosition.camera(withTarget: currentCoordinate, zoom: Float(scale))
        mapView.camera = camera
        
        routePath?.add(location.coordinate)
        routePoints.append(location)
        route?.path = routePath
        
        print(location.coordinate)
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}
