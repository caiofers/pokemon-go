//
//  PokedexViewController.swift
//  Pokemon GO
//
//  Created by Caio Fernandes on 14/04/21.
//

import UIKit

class PokedexViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
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
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Caught"
        } else {
            return "Uncaught"
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return caughtPokes.count
        } else {
            return uncaughtPokes.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "reuseCell")
        
        var pokemon: Pokemon
        var catchesText: String = ""
        
        if indexPath.section == 0 {
            pokemon = caughtPokes[indexPath.row]
            catchesText = "Catches: " + String(pokemon.catches)
        } else {
            pokemon = uncaughtPokes[indexPath.row]
        }
        
        cell.textLabel?.text = pokemon.name
        cell.detailTextLabel?.text = catchesText
        cell.imageView?.image = UIImage(named: pokemon.imageName!)
        
        return cell
    }
}
