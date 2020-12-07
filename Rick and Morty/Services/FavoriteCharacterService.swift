//
//  FavoriteCharacterService.swift
//  Rick and Morty
//
//  Created by Cleverson Luiz Correia de Souza on 07/12/20.
//  Copyright © 2020 James. All rights reserved.
//

import Foundation

class FavoriteCharacterService {
    // MARK: - Variables and Constants
    public static let shared = FavoriteCharacterService()
    private let FAVORITE_KEY = "FAVORITE_KEY"
    private let store = UserDefaults.standard
    private var characters: [Int] = [Int]()
    
    public var getFavoriteCharactersIDs: [Int] {
        return self.getStoredCharacters()
    }
    
    init() {
        self.saveCharactersToStore()
    }
    
    // MARK: - Funcs
    private func getStoredCharacters() -> [Int] {
        return self.store.array(forKey: self.FAVORITE_KEY) as? [Int] ?? [Int]()
    }
    
    private func saveCharactersToStore() {
        self.store.set(self.characters.map{$0}, forKey: self.FAVORITE_KEY)
    }
    
    func isFavoriteCharacter(widthID id: Int) -> Bool {
        return self.getStoredCharacters().contains(id)
    }
    
    func addFavoriteCharacter(withID id: Int) {
        guard isFavoriteCharacter(widthID: id) == false else { return }
        
        self.characters = self.getStoredCharacters()
        self.characters.append(id)
        self.saveCharactersToStore()
    }
    
    
    func removeFavoriteCharacter(withID id: Int) {
        self.characters = self.getStoredCharacters()
        self.characters = self.characters.filter({$0 != id})
        self.saveCharactersToStore()
    }
}
