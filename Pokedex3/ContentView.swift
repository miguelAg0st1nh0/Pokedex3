//
//  ContentView.swift
//  Pokedex3
//
//  Created by Miguel Agostinho on 24/09/2024.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Pokemon.id, ascending: true)],
        animation: .default)
    private var pokedex: FetchedResults<Pokemon>

    var body: some View {
        NavigationView {
            List {
                ForEach(pokedex) { pokemon in
                    NavigationLink {
                        Text("\(pokemon.id) : \(pokemon.name!.capitalized)")
                    } label: {
                        Text("\(pokemon.id) : \(pokemon.name!.capitalized)")
                    }
                }

            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
            }
        }
    }
}


#Preview {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
