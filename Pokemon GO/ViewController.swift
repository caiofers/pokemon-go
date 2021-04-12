//
//  ViewController.swift
//  Pokemon GO
//
//  Created by Caio Fernandes on 12/04/21.
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var mapView: MKMapView!
    var locationManager = CLLocationManager()
    var countUpdates = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
        locationManager.delegate = self
        
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        if manager.authorizationStatus == .denied {
            presentNeedLocationAlert()
        }
    }
    
    func presentNeedLocationAlert(){
        let alert = UIAlertController(title: "Localization Permission", message: "We need that you allow localization service to app works fine", preferredStyle: .alert)
        
        let openSettingsAction = UIAlertAction(title: "Open settings", style: .default, handler: {(UIAlertAction) -> Void in
            
            if let path = NSURL(string: UIApplication.openSettingsURLString){
                UIApplication.shared.open(path as URL)
            }
            
        })
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)

        alert.addAction(openSettingsAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if countUpdates < 5 {
            if let coordinates = locationManager.location?.coordinate {
                let region = MKCoordinateRegion.init(center: coordinates, latitudinalMeters: 150, longitudinalMeters: 150)
                mapView.setRegion(region, animated: true)
            }
            countUpdates += 1
        } else {
            locationManager.stopUpdatingLocation()
        }
        
    }

}

