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
        
        self.createPoke(name: "Pikachu", imageName: "pikachu-2", catches: 0)
        self.createPoke(name: "Mew", imageName: "mew", catches: 0)
        self.createPoke(name: "Charmander", imageName: "charmander", catches: 1)
        
        do {
            try context.save()
        } catch {}
        
    }
    
    func createPoke(name: String, imageName: String, catches: Int) {
        guard let context = getContext() else {
            return
        }
        
        let pokemon = Pokemon(context: context)
        pokemon.name = name
        pokemon.imageName = imageName
        pokemon.catches = Int64(catches)
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
    
    func retrievePokedexPokes(caught: Bool) -> [Pokemon] {
        guard let context = getContext() else {
            return []
        }
        
        let request = Pokemon.fetchRequest() as NSFetchRequest<Pokemon>
        request.predicate = caught ? NSPredicate(format: "catches > 0") : NSPredicate(format: "catches = 0")
        
        do {
            let result = try context.fetch(request)
            return result
        } catch {}
        
        return []
    }
    
}
