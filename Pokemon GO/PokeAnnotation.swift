//
//  PokeAnnotation.swift
//  Pokemon GO
//
//  Created by Caio Fernandes on 14/04/21.
//

import Foundation
import UIKit
import MapKit


class PokeAnnotation: NSObject, MKAnnotation{
    var pokemon: Pokemon
    var coordinate: CLLocationCoordinate2D
    
    init(coordinate: CLLocationCoordinate2D, pokemon: Pokemon) {
        self.coordinate = coordinate
        self.pokemon = pokemon
    }
}
