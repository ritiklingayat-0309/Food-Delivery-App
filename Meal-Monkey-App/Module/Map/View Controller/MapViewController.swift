//
//  MapViewController.swift
//  Meal-Monkey-App
//
//  Created by Ritik Lingayat on 12/08/25.
//

import UIKit
import MapKit

/// Protocol to notify delegate when an address is selected.
protocol MapViewControllerDelegate: AnyObject {
    func didSelectAddress(_ address: String)
}

/// Controller responsible for displaying and interacting with the map view.
class MapViewController: UIViewController, CLLocationManagerDelegate,
                         UISearchBarDelegate, MKMapViewDelegate {
    
    /// Delegate to pass the selected address back.
    weak var delegate: MapViewControllerDelegate?
    
    /// Search text field for entering addresses.
    @IBOutlet weak var txtSearch: UITextField!
    
    /// Main map view for location selection.
    @IBOutlet weak var mapView: MKMapView!
    
    /// Button to save the selected address.
    @IBOutlet weak var btnSaveAddress: UIButton!
    
    /// Button to jump to current location.
    @IBOutlet weak var btnCurrentLocation: UIButton!
    
    /// Location manager for handling location updates and permissions.
    let locationManager = CLLocationManager()
    
    /// Geocoder for converting between coordinates and human-readable addresses.
    let geocoder = CLGeocoder()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        setupUI()
        setupLocation()
        setupMap()
    }
    
    // MARK: - Actions
    /// Triggered when "Current Location" button is tapped.
    @IBAction func btnCurrentLocationAction(_ sender: Any) {
        goToCurrentLocation()
    }
    
    /// Triggered when "Current Location" button is tapped (duplicate IBAction).
    @IBAction func btnCurrentLocationTapped(_ sender: Any) {
        goToCurrentLocation()
    }
    
    /// Triggered when back button is tapped.
    @objc func BackBtnTapped() {
        if let selectedAnnotation = mapView.annotations.first(where: {
            !($0 is MKUserLocation)
        }) {
            if let title = selectedAnnotation.title ?? "", !title.isEmpty {
                delegate?.didSelectAddress(title)
            }
        }
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Setup Methods
    /// Configures UI elements such as search field, navigation title, gestures.
    private func setupUI() {
        EditStyle.setborder(textfields: [txtSearch])
        EditStyle.setPadding(textFields: [txtSearch], paddingWidth: 34)
        mapView.delegate = self
        setLeftAlignedTitleWithBack(
            "Change Address",
            target: self,
            action: #selector(BackBtnTapped)
        )
        
        let tapGesture = UITapGestureRecognizer(
            target: self,
            action: #selector(mapTapped(_:))
        )
        mapView.addGestureRecognizer(tapGesture)
        
        txtSearch.addTarget(
            self,
            action: #selector(searchAddress),
            for: .editingDidEndOnExit
        )
    }
    
    /// Sets up location manager configurations and permissions.
    private func setupLocation() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        checkLocationPermission()
    }
    
    /// Sets up default map configuration and adds initial pin.
    private func setupMap() {
        mapView.showsUserLocation = true
        // Default location (Ahmedabad, India)
        let defaultLocation = CLLocationCoordinate2D(
            latitude: 23.0225,
            longitude: 72.5714
        )
        centerMap(on: defaultLocation)
        addPinAtCenterAndReverseGeocode()
    }
    
    // MARK: - Map Handling
    /// Handles map tap gesture and updates pin/address.
    @objc func mapTapped(_ gesture: UITapGestureRecognizer) {
        let touchPoint = gesture.location(in: mapView)
        let coordinate = mapView.convert(touchPoint, toCoordinateFrom: mapView)
        updatePinAndAddress(at: coordinate)
    }
    
    /// Updates pin annotation and performs reverse geocoding.
    private func updatePinAndAddress(at coordinate: CLLocationCoordinate2D) {
        mapView.removeAnnotations(
            mapView.annotations.filter { !($0 is MKUserLocation) }
        )
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        annotation.title = "Loading address..."
        mapView.addAnnotation(annotation)
        
        let location = CLLocation(
            latitude: coordinate.latitude,
            longitude: coordinate.longitude
        )
        
        geocoder.reverseGeocodeLocation(location) { [weak self] placemarks, error in
            guard let self = self else { return }
            var fullAddress = "Unknown Location"
            
            if let placemark = placemarks?.first {
                let name = placemark.name ?? ""
                let city = placemark.locality ?? ""
                let country = placemark.country ?? ""
                fullAddress = "\(name), \(city), \(country)"
                annotation.title = name
                annotation.subtitle = "\(city), \(country)"
            }
            
            self.mapView.selectAnnotation(annotation, animated: true)
            self.delegate?.didSelectAddress(fullAddress)
        }
    }
    
    /// Searches for address using entered text and updates the map.
    @objc func searchAddress() {
        guard let query = txtSearch.text, !query.isEmpty else { return }
        
        geocoder.geocodeAddressString(query) { [weak self] placemarks, error in
            guard let self = self,
                  let placemark = placemarks?.first,
                  let location = placemark.location
            else { return }
            
            let coordinate = location.coordinate
            self.centerMap(on: coordinate)
            self.updatePinAndAddress(at: coordinate)
        }
        txtSearch.resignFirstResponder()
    }
    
    /// Moves map to user's current location.
    func goToCurrentLocation() {
        if let coordinate = locationManager.location?.coordinate {
            centerMap(on: coordinate)
            updatePinAndAddress(at: coordinate)
        } else {
            locationManager.startUpdatingLocation()
        }
    }
    
    /// Centers map on given coordinate with specified radius.
    func centerMap(
        on location: CLLocationCoordinate2D,
        regionRadius: CLLocationDistance = 1000
    ) {
        let region = MKCoordinateRegion(
            center: location,
            latitudinalMeters: regionRadius,
            longitudinalMeters: regionRadius
        )
        mapView.setRegion(region, animated: true)
    }
    
    /// Adds pin at map center and reverse geocodes it.
    func addPinAtCenterAndReverseGeocode() {
        let centerCoord = mapView.centerCoordinate
        updatePinAndAddress(at: centerCoord)
    }
    
    // MARK: - Location Permissions
    /// Checks and requests location permission if needed.
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
    
    /// Shows alert if location permission is denied.
    func showPermissionAlert() {
        let alert = UIAlertController(
            title: "Location Permission Needed",
            message: "Please enable location access in Settings to use this feature.",
            preferredStyle: .alert
        )
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alert.addAction(
            UIAlertAction(
                title: "Open Settings",
                style: .default,
                handler: { _ in
                    if let settingsURL = URL(string: UIApplication.openSettingsURLString) {
                        UIApplication.shared.open(settingsURL)
                    }
                }
            )
        )
        present(alert, animated: true)
    }
    
    // MARK: - CLLocationManagerDelegate
    func locationManager(
        _ manager: CLLocationManager,
        didUpdateLocations locations: [CLLocation]
    ) {
        guard let location = locations.last else { return }
        centerMap(on: location.coordinate)
        updatePinAndAddress(at: location.coordinate)
        locationManager.stopUpdatingLocation()
    }
    
    func locationManager(
        _ manager: CLLocationManager,
        didFailWithError error: Error
    ) {
        print("Failed to get location: \(error.localizedDescription)")
    }
    
    // MARK: - MKMapViewDelegate
    func mapView(
        _ mapView: MKMapView,
        viewFor annotation: MKAnnotation
    ) -> MKAnnotationView? {
        
        if annotation is MKUserLocation {
            return nil
        }
        
        let identifier = "CustomPin"
        var annotationView = mapView.dequeueReusableAnnotationView(
            withIdentifier: identifier
        )
        
        if annotationView == nil {
            annotationView = MKAnnotationView(
                annotation: annotation,
                reuseIdentifier: identifier
            )
            annotationView?.canShowCallout = true
            annotationView?.image = UIImage(named: "Ic_Location_Pin")
            annotationView?.centerOffset = CGPoint(
                x: 0,
                y: -(annotationView?.image?.size.height ?? 0) / 2
            )
            let button = UIButton(type: .detailDisclosure)
            annotationView?.rightCalloutAccessoryView = button
        } else {
            annotationView?.annotation = annotation
        }
        return annotationView
    }
}
