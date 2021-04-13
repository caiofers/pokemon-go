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
    
    var coreDataPokemon: CoreDataPokemon = CoreDataPokemon()
    var pokemons: [Pokemon] = []
    
    @IBAction func alignPlayerButton(_ sender: Any) {
        alignPlayer()
    }
    
    @IBAction func openPokedexButton(_ sender: Any) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
        locationManager.delegate = self
        
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        pokemons = coreDataPokemon.retriveAllPokes()
        
        showPokes()
    }
    
    func showPokes() {
        Timer.scheduledTimer(withTimeInterval: 5, repeats: true, block: {(timer) in
            if let coordinate = self.locationManager.location?.coordinate {
                let annotation = MKPointAnnotation()
                annotation.coordinate = coordinate
                
                let range = 100
                
                let randLatitude = Double(Int(arc4random_uniform(UInt32(range))) - range/2) / 100000.0
                let randLongitude = Double(Int(arc4random_uniform(UInt32(range))) - range/2) / 100000.0
                
                annotation.coordinate.latitude += randLatitude
                annotation.coordinate.longitude += randLongitude

                self.mapView.addAnnotation(annotation)
            }
        })
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: nil)
        
        if annotation is MKUserLocation {
            annotationView.image = UIImage(named: "player")
        } else {
            let pokeIndex =  Int(arc4random_uniform(UInt32(pokemons.count)))
            annotationView.image = UIImage(named: pokemons[pokeIndex].imageName ?? "")
        }
        
        var frame = annotationView.frame
        frame.size.height = 40
        frame.size.width = 40
        
        annotationView.frame = frame
        
        return annotationView
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
            alignPlayer()
            countUpdates += 1
        } else {
            locationManager.stopUpdatingLocation()
        }
        
    }
    
    func alignPlayer() {
        if let coordinates = locationManager.location?.coordinate {
            let region = MKCoordinateRegion.init(center: coordinates, latitudinalMeters: 150, longitudinalMeters: 150)
            mapView.setRegion(region, animated: true)
        }
    }

}

