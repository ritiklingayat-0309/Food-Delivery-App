//
//  MapViewController.swift
//  Meal-Monkey-App
//
//  Created by Ritik Lingayat on 12/08/25.
//

import UIKit
import MapKit

protocol MapViewControllerDelegate: AnyObject {
    func didSelectAddress(_ address: String)
}

class MapViewController: UIViewController {
    weak var delegate: MapViewControllerDelegate?
    @IBOutlet weak var txtSearch: UITextField!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var btnSaveAddress: UIButton!

    @IBOutlet weak var btnCurrentLocation: UIButton!
    let locationManager = CLLocationManager()
    let geocoder = CLGeocoder()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        EditStyle.setPadding(textFields: [txtSearch], paddingWidth: 28)
        EditStyle.setborder(textfields: [txtSearch])
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        checkLocationPermission()
        mapView.showsUserLocation = true
        let location = CLLocationCoordinate2D(
            latitude: 23.0225,
            longitude: 72.5714
        )
        
        centerMap(on: location)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.addPinAtCenterAndReverseGeocode()
        }
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(mapTapped(_:)))
        mapView.addGestureRecognizer(tapGesture)
        
        setLeftAlignedTitleWithBack(
            "Change Address",
            target: self,
            action: #selector(backBtnTapped)
        )
        setLeftAlignedTitleWithBack("Change Address", target: self, action: #selector(backBtnTapped))
    }
    
    @objc func mapTapped(_ gesture: UITapGestureRecognizer) {
        let touchPoint = gesture.location(in: mapView)
        let coordinate = mapView.convert(touchPoint, toCoordinateFrom: mapView)
        
        // Remove old pins
        mapView.removeAnnotations(mapView.annotations.filter { !($0 is MKUserLocation) })
        
        // Add new pin
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        annotation.title = "Loading address..."
        mapView.addAnnotation(annotation)
        
        // Get location details
        let location = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
        CLGeocoder().reverseGeocodeLocation(location) { [weak self] placemarks, error in
            guard let self = self else { return }
            if let placemark = placemarks?.first {
                var addressComponents: [String] = []
                if let name = placemark.name { addressComponents.append(name) }
                if let thoroughfare = placemark.thoroughfare { addressComponents.append(thoroughfare) }
                if let subLocality = placemark.subLocality { addressComponents.append(subLocality) }
                if let locality = placemark.locality { addressComponents.append(locality) }
                if let administrativeArea = placemark.administrativeArea { addressComponents.append(administrativeArea) }
                if let postalCode = placemark.postalCode { addressComponents.append(postalCode) }
                if let country = placemark.country { addressComponents.append(country) }
                let fullAddress = addressComponents.joined(separator: ", ")
                annotation.title = placemark.name ?? "Selected Location"
                annotation.subtitle = fullAddress //
            } else {
                annotation.title = "Lat: \(coordinate.latitude), Lon: \(coordinate.longitude)"
                annotation.subtitle = nil
            }
            
            // Refresh annotation view
            self.mapView.selectAnnotation(annotation, animated: true)
        }
    }
    
    func checkLocationPermission() {
        if #available(iOS 14.0, *) {
            switch locationManager.authorizationStatus {
            case .notDetermined:
                locationManager.requestWhenInUseAuthorization()
            case .denied, .restricted:
                showPermissionAlert()
            case .authorizedWhenInUse, .authorizedAlways:
                locationManager.startUpdatingLocation()
            @unknown default:
                break
            }
        } else {
            let status = CLLocationManager.authorizationStatus()
            if status == .notDetermined {
                locationManager.requestWhenInUseAuthorization()
            } else if status == .denied || status == .restricted {
                showPermissionAlert()
            } else {
                locationManager.startUpdatingLocation()
            }
        }
    }
    
    func showPermissionAlert() {
        let alert = UIAlertController(
            title: "Location Permission Needed",
            message:
                "Please enable location access in Settings to use this feature.",
            preferredStyle: .alert
        )
        alert.addAction(
            UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        )
        alert.addAction(
            UIAlertAction(
                title: "Open Settings",
                style: .default,
                handler: { _ in
                    if let settingsURL = URL(
                        string: UIApplication.openSettingsURLString
                    ) {
                        UIApplication.shared.open(settingsURL)
                    }
                }
            )
        )
        present(alert, animated: true)
    }
    
    func locationManager(
        _ manager: CLLocationManager,
        didUpdateLocations locations: [CLLocation]
    ) {
        guard let location = locations.last else { return }
        
        let region = MKCoordinateRegion(
            center: location.coordinate,
            span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        )
        mapView.setRegion(region, animated: true)
        
        let annotations = mapView.annotations.filter { !($0 is MKUserLocation) }
        mapView.removeAnnotations(annotations)
        
        // Add pin for current location
        let annotation = MKPointAnnotation()
        annotation.coordinate = location.coordinate
        annotation.title = "You are here"
        mapView.addAnnotation(annotation)
        
        // Stop further updates to save battery
        locationManager.stopUpdatingLocation()
    }
    
    func locationManager(
        _ manager: CLLocationManager,
        didFailWithError error: Error
    ) {
        print("Failed to get location: \(error.localizedDescription)")
    }
    
    func centerMap(
        on location: CLLocationCoordinate2D,
        regionRadius: CLLocationDistance = 1000
    ) {
        let coordinateRegion = MKCoordinateRegion(
            center: location,
            latitudinalMeters: regionRadius,
            longitudinalMeters: regionRadius
        )
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    func addPinAtCenterAndReverseGeocode() {
        let centerCoord = mapView.centerCoordinate
        let location = CLLocation(
            latitude: centerCoord.latitude,
            longitude: centerCoord.longitude
        )
        
        geocoder.reverseGeocodeLocation(location) { [weak self] placemarks, error in
            guard let self = self else { return }
            if let error = error {
                print("Reverse geocoding failed: \(error.localizedDescription)")
                return
            }
            
            var address = "Unknown Location"
            if let placemark = placemarks?.first {
                // Build the full address string from the placemark details
                var addressComponents: [String] = []
                if let name = placemark.name { addressComponents.append(name) }
                if let thoroughfare = placemark.thoroughfare { addressComponents.append(thoroughfare) }
                if let subLocality = placemark.subLocality { addressComponents.append(subLocality) }
                if let locality = placemark.locality { addressComponents.append(locality) }
                if let administrativeArea = placemark.administrativeArea { addressComponents.append(administrativeArea) }
                if let postalCode = placemark.postalCode { addressComponents.append(postalCode) }
                if let country = placemark.country { addressComponents.append(country) }
                
                address = addressComponents.joined(separator: ", ")
            }
            
            // Remove old pins to prevent duplicates
            self.mapView.removeAnnotations(self.mapView.annotations.filter { !($0 is MKUserLocation) })
            
            let annotation = MKPointAnnotation()
            annotation.coordinate = centerCoord
            annotation.title = "Selected Location"
            annotation.subtitle = address // Set the full address as the subtitle
            self.mapView.addAnnotation(annotation)
        }
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
            return nil // keep blue dot for user location
        }
        
        let identifier = "CustomPin"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
        
        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = true
            
            // Set custom image from assets as pin
            annotationView?.image = UIImage(named: "Ic_Location_Pin") // asset name
            annotationView?.centerOffset = CGPoint(x: 0, y: -(annotationView?.image?.size.height ?? 0) / 2)
            
            // Right detail button
            let button = UIButton(type: .detailDisclosure)
            annotationView?.rightCalloutAccessoryView = button
        } else {
            annotationView?.annotation = annotation
        }
        return annotationView
    }
    
    @IBAction func btnCurrentLocationTapped(_ sender: Any) {
        if CLLocationManager.locationServicesEnabled() {
            switch locationManager.authorizationStatus {
            case .notDetermined:
                locationManager.requestWhenInUseAuthorization()
            case .denied, .restricted:
                showPermissionAlert()
            case .authorizedWhenInUse, .authorizedAlways:
                locationManager.startUpdatingLocation()
            @unknown default:
                break
            }
        } else {
            showPermissionAlert()
        }
    }
    
    func goToCurrentLocation() {
        if let location = locationManager.location?.coordinate {
            let region = MKCoordinateRegion(
                center: location,
                span: MKCoordinateSpan(
                    latitudeDelta: 0.01,
                    longitudeDelta: 0.01
                )
            )
            mapView.setRegion(region, animated: true)
        } else {
            locationManager.startUpdatingLocation()
        }
    }
    
    @IBAction func btnCurrentLocationAction(_ sender: Any) {
        if let pin = mapView.annotations.first(where: { !($0 is MKUserLocation) }) {
            if let address = pin.subtitle {
                delegate?.didSelectAddress(address ?? "")
            }
        }
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @objc func backBtnTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnSaveAddress(_ sender: Any) {
        
    }
}
