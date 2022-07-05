//
//  PokemonImageView.swift
//  Pokedex
//
//  Created by Matheus Mendes Peres on 05/07/22.
//

import SwiftUI

struct PokemonImageView: View {
    var imageLink = ""
    @State private var pokemonSprite = ""
    
    var body: some View {
        AsyncImage(url: URL(string: pokemonSprite))
            .frame(width: 75, height: 75)
            .onAppear {
                let loadedData = UserDefaults.standard.string(forKey: imageLink)
                
                if loadedData == nil {
                    getSprite(url: imageLink)
                    UserDefaults.standard.set(imageLink, forKey: imageLink)
                } else {
                    getSprite(url: loadedData!)
                }
            }
            .clipShape(Circle())
            .foregroundColor(Color.gray.opacity(0.60))
            .scaledToFit()
        
    }
    
    func getSprite(url: String) {
        var tempSprite: String?
        PokemonSelectedApi().getSprite(url: url) { sprite in
            tempSprite = sprite.front_default
            self.pokemonSprite = tempSprite ?? "placeholder"
        }
        
    }
}

struct PokemonImageView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonImageView()
            .previewInterfaceOrientation(.portrait)
    }
}
