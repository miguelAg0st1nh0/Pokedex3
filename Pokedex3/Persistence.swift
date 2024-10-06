//
//  Persistence.swift
//  Pokedex3
//
//  Created by Miguel Agostinho on 24/09/2024.
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()
    let container: NSPersistentContainer
    
    @MainActor
    static let preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        let samplePokemon = Pokemon(context: viewContext)
        samplePokemon.id = 1
        samplePokemon.name = "charmander"
        samplePokemon.sprite = URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/4.png")
        samplePokemon.shinySprite = URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/4.png")
        samplePokemon.types = ["fire"]
        samplePokemon.hp = 39
        samplePokemon.attack = 52
        samplePokemon.defense = 43
        samplePokemon.specialAttack = 60
        samplePokemon.specialDefense = 50
        samplePokemon.speed = 65
        samplePokemon.favourite = false
        
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return result
    }()

    

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "Pokedex3")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
}
