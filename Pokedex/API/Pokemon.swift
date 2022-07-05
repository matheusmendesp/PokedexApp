//
//  Pokemon.swift
//  Pokedex
//
//  Created by Matheus Mendes Peres on 05/07/22.
//

import Foundation

struct Pokemon: Codable {
    var results: [PokemonEntry]
}

struct PokemonEntry: Codable, Identifiable {
    let id = UUID()
    var name: String
    var url: String
}

class PokeApi {
    func getData(completion: @escaping ([PokemonEntry]) -> ()){
        guard let url: URL = URL(string: "https://pokeapi.co/api/v2/pokemon?limit=151") else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, Error in
            guard let data: Data = data else { return }
            
            let pokemonList = try! JSONDecoder().decode(Pokemon.self, from: data)
            
            DispatchQueue.main.async {
                completion(pokemonList.results)
            }
        }.resume()
    }
}
