//
//  CharacterBuilder.swift
//  Rick and MortyTests
//
//  Created by Cleverson Luiz Correia de Souza on 06/12/20.
//  Copyright © 2020 James. All rights reserved.
//

import UIKit
@testable import Rick_and_Morty

class CharacterBuilder: NSObject {
    public static let shared = CharacterBuilder()
    
    lazy var characters: [CharacterData] = {
        let rickSanchez = CharacterData(id: 1,
                                        name: "Rick Sanchez",
                                        status: "Alive",
                                        species: "Human",
                                        gender: "Male",
                                        image: "https://rickandmortyapi.com/api/character/avatar/1.jpeg",
                                        location: nil,
                                        origin: nil,
                                        episode: [])
        
        let morthySmith = CharacterData(id: 2,
                                        name: "Morty Smith",
                                        status: "Alive",
                                        species: "Human",
                                        gender: "Male",
                                        image: "https://rickandmortyapi.com/api/character/avatar/2.jpeg",
                                        location: nil,
                                        origin: nil,
                                        episode: [])
        
        let sheikRick = CharacterData(id: 484,
                                      name: "Sheik Rick",
                                      status: "Dead",
                                      species: "Human",
                                      gender: "Male",
                                      image: "https://rickandmortyapi.com/api/character/avatar/484.jpeg",
                                      location: nil,
                                      origin: nil,
                                      episode: [])
        
        var characters = [CharacterData]()
        characters.append(contentsOf: [rickSanchez, morthySmith, sheikRick])
        
        return characters
    }()
    
    func getRandomCharacter() -> CharacterData {
        let index = Int.random(in: 0 ..< characters.count)
        return self.characters[index]
    }
    
    func getCharacterWith(id: Int) -> CharacterData? {
        return self.characters.filter({ $0.id == id}).first
    }
    
    override init() {
        super.init()
    }
}
