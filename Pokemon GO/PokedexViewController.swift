//
//  PokedexViewController.swift
//  Pokemon GO
//
//  Created by Caio Fernandes on 14/04/21.
//

import UIKit

class PokedexViewController: UIViewController {

    var caughtPokes: [Pokemon] = []
    var uncaughtPokes: [Pokemon] = []

    @IBAction func backToMap(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let coreData = CoreDataPokemon()
        caughtPokes = coreData.retrievePokedexPokes(caught: true)
        uncaughtPokes = coreData.retrievePokedexPokes(caught: false)
    }
}
