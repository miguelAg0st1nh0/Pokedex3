//
//  TempPokemon.swift
//  Pokedex3
//
//  Created by Miguel Agostinho on 25/09/2024.
//

import Foundation

struct TempPokemon: Decodable {
    
    let id: Int
    let name: String
    let types: [String]
    var hp = 0
    var attack = 0
    var defense = 0
    var specialAttack = 0
    var specialDefense = 0
    var speed = 0
    let sprite: URL
    let shiny: URL
    
    enum CodingKeys: String, CodingKey {
        
        case id
        case name
        case types
        case stats
        case sprites
        
        enum TypeDictionaryKeys: String, CodingKey {
            
            case type
            
            enum TypeKeys: String, CodingKey {
                
                case name
            }
        }
        
        enum StatDictionaryKeys: String, CodingKey {
            
            case value = "base_stat"
            case stat
            
            enum StatKeys: String, CodingKey {
                
                case name
            }
        }
        
        enum SpriteKeys: String, CodingKey {
            
            case sprite = "front_default"
            case shiny = "front_shiny"
        }
        
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        
        var decodedTypes: [String] = []
        
        var typeContainer = try container.nestedUnkeyedContainer(forKey: .types)
        while !typeContainer.isAtEnd {
            let typesDictionaryContainer = try typeContainer.nestedContainer(keyedBy: CodingKeys.TypeDictionaryKeys.self)
            let typesContainer = try typesDictionaryContainer.nestedContainer(keyedBy: CodingKeys.TypeDictionaryKeys.TypeKeys.self, forKey: .type)
            
            let type = try typesContainer.decode(String.self, forKey: .name)
            decodedTypes.append(type)
        }
        types = decodedTypes
        
        var statsContainer = try container.nestedUnkeyedContainer(forKey: .stats)
        while !statsContainer.isAtEnd {
            let statsDictionaryContainer = try statsContainer.nestedContainer(keyedBy: CodingKeys.StatDictionaryKeys.self)
            let statContainer = try statsDictionaryContainer.nestedContainer(keyedBy: CodingKeys.StatDictionaryKeys.StatKeys.self, forKey: .stat)
            
            switch try statContainer.decode(String.self, forKey: .name) {
            case "hp":
                hp = try statsDictionaryContainer.decode(Int.self, forKey: .value)
            case "attack":
                attack = try statsDictionaryContainer.decode(Int.self, forKey: .value)
            case "defense":
                defense = try statsDictionaryContainer.decode(Int.self, forKey: .value)
            case "special-attack":
                specialAttack = try statsDictionaryContainer.decode(Int.self, forKey: .value)
            case "special-defense":
                specialDefense = try statsDictionaryContainer.decode(Int.self, forKey: .value)
            case "speed":
                speed = try statsDictionaryContainer.decode(Int.self, forKey: .value)
            default:
                print("")
            }
            
        }
        
        let spriteContainer = try container.nestedContainer(keyedBy: CodingKeys.SpriteKeys.self, forKey: .sprites)
        sprite = try spriteContainer.decode(URL.self, forKey: .sprite)
        shiny = try spriteContainer.decode(URL.self, forKey: .shiny)
        
        
    }
    
}
