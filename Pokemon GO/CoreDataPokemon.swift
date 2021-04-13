//
//  CoreDataPokemon.swift
//  Pokemon GO
//
//  Created by Caio Fernandes on 13/04/21.
//

import Foundation
import UIKit
import CoreData

class CoreDataPokemon {
    
    func getContext() -> NSManagedObjectContext? {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        let context = appDelegate?.persistentContainer.viewContext
        return context
    }
    
    func addAllPokes() {
        
        guard let context = self.getContext() else {
            return
        }
        
        self.createPoke(name: "Pikachu", imageName: "pikachu-2", timesCaptured: 0)
        self.createPoke(name: "Mew", imageName: "mew", timesCaptured: 0)
        self.createPoke(name: "Charmander", imageName: "chamander", timesCaptured: 1)
        
        do {
            try context.save()
        } catch {}
        
    }
    
    func createPoke(name: String, imageName: String, timesCaptured: Int) {
        guard let context = getContext() else {
            return
        }
        
        let pokemon = Pokemon(context: context)
        pokemon.name = name
        pokemon.imageName = imageName
        pokemon.timesCaptured = Int64(timesCaptured)
    }
    
    func retriveAllPokes() -> [Pokemon] {
        guard let context = getContext() else {
            return []
        }
        
        do {
            let result = try context.fetch(Pokemon.fetchRequest()) as! [Pokemon]
            
            if result.count == 0 {
                self.addAllPokes()
                return retriveAllPokes()
            }
            
            return result
        } catch {}
        
        return []
    }
    
}
